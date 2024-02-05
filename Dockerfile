# Use an Arch Linux base image
FROM archlinux:latest

# Update system and install sudo, git, and ansible (all in one layer to keep the image size down)
RUN pacman -Syu --noconfirm && \
    pacman -S sudo git ansible openssh --noconfirm

RUN if [ -z "$(command -v ssh-keygen )" ]; then echo "ssh-keygen not found" && exit 1; fi

# Generate SSH host keys
RUN ssh-keygen -A && echo "SSH host keys generated." > /home/wurfkreuz/.dotfiles/ssh_keygen_output.txt

# Create a new user for Ansible (replace 'wurfkreuz' with your preferred username)
# And configure sudoers to allow passwordless sudo
RUN useradd -m wurfkreuz && \
    echo "wurfkreuz ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/wurfkreuz && \
    chmod 0440 /etc/sudoers.d/wurfkreuz

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Switch to your new user
USER wurfkreuz

# Set working directory
WORKDIR /home/wurfkreuz

# Expose SSH port
EXPOSE 22

# Use exec form to ensure signals are properly handled by SSHD
CMD ["/usr/sbin/sshd", "-D"]

# # To not let the container stop
# CMD ["/bin/bash"] 
# # or i can use 'tail -f /dev/null' as a dummy command

# (Optional) Install SSH server if you plan to connect via SSH
# RUN pacman -S openssh --noconfirm \
#     && sudo systemctl enable sshd.service


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

# 'tail' is a Unix and Linux utility that displays the end of a text file or piped data. By default, tail prints the last 10 lines of its input to the standard output (stdout).
# The -f option stands for "follow." When used with tail, it causes tail to not
# stop when the end of the file is reached, but rather to wait for additional
# data to be appended to the input. In essence, tail -f is used to continuously
# monitor the tail of a file, printing new lines as they are appended.



