#!/bin/sh

source /build/ENV

mvn -Dcas.version=$CAS_VERSION clean package
