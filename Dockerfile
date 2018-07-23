FROM python:3.6.2-alpine3.6
COPY psmcli.zip .
RUN pip3 install -U psmcli.zip
COPY docker-expand-env.sh .
COPY docker-entrypoint.sh .
RUN cat /docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["psm"]
