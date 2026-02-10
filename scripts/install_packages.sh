#!/usr/bin/env bash
# install_packages.sh — One-command setup for a fresh Ubuntu/Debian machine
# after cloning dotfiles and running `stow .`
#
# Usage: bash scripts/install_packages.sh
# Idempotent: safe to run multiple times.

set -euo pipefail

# ---------------------------------------------------------------------------
# Colors
# ---------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info()    { printf "${BLUE}[INFO]${NC} %s\n" "$*"; }
success() { printf "${GREEN}[OK]${NC}   %s\n" "$*"; }
warn()    { printf "${YELLOW}[WARN]${NC} %s\n" "$*"; }
error()   { printf "${RED}[ERR]${NC}  %s\n" "$*"; }

# ---------------------------------------------------------------------------
# Preflight
# ---------------------------------------------------------------------------
if [[ "$(uname)" != "Linux" ]]; then
    error "This script is intended for Linux (Ubuntu/Debian). Exiting."
    exit 1
fi

if ! command -v apt-get &>/dev/null; then
    error "apt-get not found. This script requires a Debian-based system."
    exit 1
fi

mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# ---------------------------------------------------------------------------
# 1. System packages (apt)
# ---------------------------------------------------------------------------
install_apt_packages() {
    info "Installing system packages via apt..."
    sudo apt-get update -y

    local packages=(
        git stow tmux zsh curl wget
        build-essential
        ripgrep fd-find
        tree jq unzip fzf htop
        xclip
        python3-pip python3-venv
        # pyenv build deps
        libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev
        libffi-dev liblzma-dev
        # rbenv build deps
        autoconf patch libyaml-dev
    )

    sudo apt-get install -y "${packages[@]}"
    success "System packages installed."
}

# ---------------------------------------------------------------------------
# 2. Neovim (latest stable AppImage)
# ---------------------------------------------------------------------------
install_neovim() {
    if command -v nvim &>/dev/null; then
        local current
        current="$(nvim --version | head -1)"
        success "Neovim already installed: $current"
        return
    fi

    info "Installing Neovim (latest stable AppImage)..."
    local url="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"
    local dest="$HOME/.local/bin/nvim"

    curl -fLo "$dest" "$url"
    chmod u+x "$dest"

    # Test if AppImage runs (FUSE may not be available)
    if "$dest" --version &>/dev/null; then
        success "Neovim AppImage installed to $dest"
    else
        warn "FUSE unavailable — extracting AppImage..."
        local tmpdir
        tmpdir="$(mktemp -d)"
        cd "$tmpdir"
        "$dest" --appimage-extract &>/dev/null || true
        rm -f "$dest"
        mv squashfs-root "$HOME/.local/lib/nvim"
        ln -sf "$HOME/.local/lib/nvim/AppRun" "$dest"
        cd -
        rm -rf "$tmpdir"
        success "Neovim extracted and linked to $dest"
    fi
}

# ---------------------------------------------------------------------------
# 3. Node.js 22 via nvm
# ---------------------------------------------------------------------------
install_node() {
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

    if [[ -s "$NVM_DIR/nvm.sh" ]]; then
        # shellcheck source=/dev/null
        source "$NVM_DIR/nvm.sh"
    fi

    if command -v node &>/dev/null && node -v | grep -q '^v22'; then
        success "Node.js 22 already installed: $(node -v)"
        return
    fi

    info "Installing nvm + Node.js 22..."
    if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
        curl -fso- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
        # shellcheck source=/dev/null
        source "$NVM_DIR/nvm.sh"
    fi

    nvm install 22
    success "Node.js installed: $(node -v)"
}

# ---------------------------------------------------------------------------
# 4. Zsh + Oh My Zsh
# ---------------------------------------------------------------------------
install_ohmyzsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        success "Oh My Zsh already installed."
    else
        info "Installing Oh My Zsh (keeping existing .zshrc)..."
        KEEP_ZSHRC=yes sh -c \
            "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
            "" --unattended
        success "Oh My Zsh installed."
    fi

    # Set zsh as default shell
    local zsh_path
    zsh_path="$(command -v zsh)"
    if [[ "$SHELL" != "$zsh_path" ]]; then
        info "Changing default shell to zsh..."
        chsh -s "$zsh_path"
        success "Default shell set to zsh."
    fi
}

# ---------------------------------------------------------------------------
# 5. Zsh plugins
# ---------------------------------------------------------------------------
install_zsh_plugins() {
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    local -A plugins=(
        [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
        [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
    )

    for name in "${!plugins[@]}"; do
        local dest="$zsh_custom/plugins/$name"
        if [[ -d "$dest" ]]; then
            success "Zsh plugin $name already installed."
        else
            info "Cloning $name..."
            git clone "${plugins[$name]}" "$dest"
            success "Installed $name."
        fi
    done
}

# ---------------------------------------------------------------------------
# 6. pyenv
# ---------------------------------------------------------------------------
install_pyenv() {
    if [[ -d "$HOME/.pyenv" ]]; then
        success "pyenv already installed."
        return
    fi

    info "Installing pyenv..."
    curl -fsSL https://pyenv.run | bash
    success "pyenv installed."
}

# ---------------------------------------------------------------------------
# 7. rbenv + ruby-build
# ---------------------------------------------------------------------------
install_rbenv() {
    if [[ -d "$HOME/.rbenv" ]]; then
        success "rbenv already installed."
        return
    fi

    info "Installing rbenv..."
    git clone https://github.com/rbenv/rbenv.git "$HOME/.rbenv"

    mkdir -p "$HOME/.rbenv/plugins"
    git clone https://github.com/rbenv/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"
    success "rbenv + ruby-build installed."
}

# ---------------------------------------------------------------------------
# 8. uv (Python package manager)
# ---------------------------------------------------------------------------
install_uv() {
    if command -v uv &>/dev/null; then
        success "uv already installed: $(uv --version)"
        return
    fi

    info "Installing uv..."
    curl -fsSL https://astral.sh/uv/install.sh | sh
    success "uv installed."
}

# ---------------------------------------------------------------------------
# 9. Additional tools (bat, eza, fd symlink)
# ---------------------------------------------------------------------------
install_additional_tools() {
    # bat: apt installs as batcat on Ubuntu — create symlink
    if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
        info "Creating bat symlink (batcat -> bat)..."
        ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
        success "bat symlink created."
    fi

    # fd: apt installs as fdfind — create symlink for telescope
    if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
        info "Creating fd symlink (fdfind -> fd)..."
        ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
        success "fd symlink created."
    fi

    # eza: install from eza community repo
    if command -v eza &>/dev/null; then
        success "eza already installed."
    else
        info "Installing eza from community repo..."
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc \
            | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" \
            | sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt-get update -y
        sudo apt-get install -y eza
        success "eza installed."
    fi

    # bat: install from apt if not present at all
    if ! command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
        info "Installing bat..."
        sudo apt-get install -y bat
        if command -v batcat &>/dev/null; then
            ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
        fi
        success "bat installed."
    fi
}

# ---------------------------------------------------------------------------
# 10. Nerd Fonts
# ---------------------------------------------------------------------------
install_nerd_fonts() {
    local font_dir="$HOME/.local/share/fonts"
    mkdir -p "$font_dir"

    local -A fonts=(
        [MesloLG]="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz"
        [Iosevka]="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Iosevka.tar.xz"
    )

    for name in "${!fonts[@]}"; do
        if fc-list | grep -qi "$name.*Nerd"; then
            success "Nerd Font $name already installed."
            continue
        fi

        info "Downloading $name Nerd Font..."
        local tmpfile
        tmpfile="$(mktemp)"
        curl -fLo "$tmpfile" "${fonts[$name]}"
        local dest="$font_dir/$name"
        mkdir -p "$dest"
        tar -xf "$tmpfile" -C "$dest"
        rm -f "$tmpfile"
        success "$name Nerd Font installed."
    done

    info "Rebuilding font cache..."
    fc-cache -f
    success "Font cache updated."
}

# ---------------------------------------------------------------------------
# 11. Tmux plugins
# ---------------------------------------------------------------------------
install_tmux_plugins() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [[ -d "$tpm_dir" ]]; then
        success "TPM already installed."
    else
        info "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        success "TPM installed."
    fi

    info "Installing tmux plugins (headless)..."
    "$tpm_dir/bin/install_plugins" || warn "tmux plugin install had issues (tmux may not be running)."
    success "Tmux plugins installed."
}

# ---------------------------------------------------------------------------
# 12. Kitty terminfo
# ---------------------------------------------------------------------------
install_kitty_terminfo() {
    local ti_file="$HOME/.dotfiles/.terminfo/x/xterm-kitty.ti"

    if [[ ! -f "$ti_file" ]]; then
        warn "xterm-kitty.ti not found at $ti_file — skipping."
        return
    fi

    info "Compiling kitty terminfo..."
    tic -x -o "$HOME/.terminfo" "$ti_file"
    success "Kitty terminfo compiled."
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    printf "\n${BLUE}=== Dotfiles Linux Installer ===${NC}\n\n"

    install_apt_packages
    install_neovim
    install_node
    install_ohmyzsh
    install_zsh_plugins
    install_pyenv
    install_rbenv
    install_uv
    install_additional_tools
    install_nerd_fonts
    install_tmux_plugins
    install_kitty_terminfo

    # -------------------------------------------------------------------
    # 13. Post-install notes
    # -------------------------------------------------------------------
    printf "\n${GREEN}=== Installation Complete ===${NC}\n\n"

    cat <<'NOTES'
Next steps:

  1. Restart your shell (or run: exec zsh)

  2. Open nvim — Lazy.nvim will auto-install plugins on first launch.
     Then run :Mason to install LSP servers.

  3. In tmux, press prefix + I (Ctrl-a + I) to install tmux plugins.

  4. Install a Python version:  pyenv install 3.12
  5. Install a Ruby version:   rbenv install 3.3.0

Linux .zshrc note:
  Lines 115-116 in .zshrc source Homebrew paths that don't exist on Linux:
    source /opt/homebrew/share/zsh-syntax-highlighting/...
    source /opt/homebrew/share/zsh-autosuggestions/...
  These produce non-fatal "file not found" errors. The plugins still work
  because Oh My Zsh loads them from $ZSH_CUSTOM/plugins/. To silence the
  errors, wrap them:
    [[ -f /opt/homebrew/share/zsh-syntax-highlighting/... ]] && source ...

NOTES
}

main "$@"
