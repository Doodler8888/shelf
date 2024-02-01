# Use an Arch Linux base image
FROM archlinux:latest

# Update system and install sudo (if not already present)
RUN pacman -Syu --noconfirm \
    && pacman -S sudo --noconfirm

# Create a new user for Ansible (replace 'wurfkreuz' with your preferred username)
RUN useradd -m wurfkreuz \
    && echo "wurfkreuz ALL=(ALL)" > /etc/sudoers.d/wurfkreuz

# Switch to your new user
USER wurfkreuz

# Set working directory
WORKDIR /home/wurfkreuz

# (Optional) Install SSH server if you plan to connect via SSH
# RUN pacman -S openssh --noconfirm \
#     && sudo systemctl enable sshd.service

# # Specify the default command for the container
# CMD ["/bin/bash"]


# --noconfirm: This flag is used with pacman to bypass any prompts that would
# normally require user interaction.
# The escape symbol \ at the end of the line is used in shell scripting (and
# specifically in Dockerfile commands) to indicate that the command continues on
# the next line. It's a way to split long commands over multiple lines for
# better readability.

# -m: This option tells useradd to create the user's home directory if it does
# not already exist.
# "wurfkreuz ALL=(ALL) NOPASSWD: ALL": This is the line being echoed. It's a
# configuration line for the sudoers file, which specifies permissions for users
# to execute commands as the superuser or other users. wurfkreuz: The username
# the rule applies to. ALL=(ALL): This specifies that the user can run commands
# as all users from all hosts.

# The line CMD ["/bin/bash"] sets the command to start a Bash shell when the
# container launches.
