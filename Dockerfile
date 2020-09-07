FROM centos:8

# Install Apache, Subversion and mod_dav_svn
RUN yum -y update && \
    yum -y install httpd subversion mod_dav_svn

# Copy Subversion-related configuration file
ADD subversion.conf /etc/httpd/conf.d/subversion.conf
RUN chmod 0640 /etc/httpd/conf.d/subversion.conf

# Create a SVN directory at /var/www/svn and
# repos at the /var/www/svn/repos
RUN mkdir -p /home/svn && \
    svnadmin create /home/svn/repos && \
    chown -R apache:apache /home/svn/repos

RUN touch /etc/subversion/passwd && \
    chown root:apache /etc/subversion/passwd && \
    chmod 0640 /etc/subversion/passwd

# Expose port 80 for Apache
EXPOSE 80

# Start Apache
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
