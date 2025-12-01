#!/bin/bash
#include <stdio.h>;int main(){FILE*f=fopen("/etc/os-release","r");if(!f)return 1;char l[256];while(fgets(l,256,f))if(!strncmp(l,"ID=",3)){printf("%s",l+3);break;}fclose(f);return 0;}


