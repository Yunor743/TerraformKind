
FROM debian:buster
COPY subnet.env /root/
COPY init.sh /root/
RUN /root/init.sh
CMD ["/sbin/init"]
