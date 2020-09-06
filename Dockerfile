FROM centos:8

# Install Apache, Subversion and mod_dav_svn
RUN yum -y update && \
    yum -y install httpd subversion mod_dav_svn

# Copy Subversion-related configuration file
ADD subversion.conf /etc/httpd/conf.d/subversion.conf
RUN chmod 0640 /etc/httpd/conf.d/subversion.conf

# Expose port 80 for Apache
EXPOSE 80

# Start Apache
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
