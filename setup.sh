echo "===== Shell configuration ====="
echo "Do you wish to configure your shell? (Yy/Nn)\c"
read -r answer
if [[ $answer != "${answer#[Yy]}" ]]; then
    ./setupShell.sh
else
    echo "Skipping..."
fi

echo ""
echo "===== Git Globals configuration ====="
#TODO: Run a diff against git config if it already exists.
echo "Do you wish to configure git globals? (Yy/Nn)\c"
read -r answer
if [[ $answer != "${answer#[Yy]}" ]]; then
    ln -snf "${PWD}"/git/config "${HOME}"/.gitconfig
    echo "Symlinked ${PWD}/git/config to ${HOME}/.gitconfig"
else
    echo "Skipping..."
    echo ""
fi
