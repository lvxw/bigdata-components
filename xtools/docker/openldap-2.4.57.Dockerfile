FROM osixia/openldap:latest

ARG OPENLDAP_VERSION="2.4.57"

ADD /dependency/openldap-${OPENLDAP_VERSION}/ou_ldif_file.ldif  /usr/local/src/
ADD /dependency/openldap-${OPENLDAP_VERSION}/user_ldif_file.ldif  /usr/local/src/

ADD /dependency/openldap-${OPENLDAP_VERSION}/entrypoint.sh  /usr/local/bin/

ENTRYPOINT ["bash", "/usr/local/bin/entrypoint.sh"]
