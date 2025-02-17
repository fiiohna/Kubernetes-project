FROM centos

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y install java

# Install wget
RUN yum install -y wget

# Download the ZIP file using wget.  Adjust the output filename if needed after inspecting the templatemo URL.
RUN wget -O /var/www/html/templatemo_590_topic_listing.zip https://templatemo.com/download/templatemo_590_topic_listing

WORKDIR /var/www/html/

# Unzip the file.  Use the correct filename here.
RUN unzip -q templatemo_590_topic_listing.zip

# Assuming the unzipped content is in a directory like "templatemo_590_topic_listing", copy it:
RUN cp -rvf templatemo_590_topic_listing/* .
RUN rm -rf templatemo_590_topic_listing templatemo_590_topic_listing.zip

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80 22
