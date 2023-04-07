#get AD schema
dsquery * "cn=schema,cn=configuration,dc=SEMCTY,dc=NET" -scope base -attr objectVersion
