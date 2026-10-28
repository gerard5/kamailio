message(STATUS "Configuring for OpenBSD")

# Needs LIBSSL_SET_MUTEX_SHARED, KSR_PTHREAD_MUTEX_SHARED to be disabled

target_compile_definitions(
  common
  INTERFACE USE_SIGWAIT
            HAVE_SOCKADDR_SA_LEN
            HAVE_GETHOSTBYNAME2
            HAVE_UNION_SEMUN
            HAVE_SCHED_YIELD
            HAVE_MSGHDR_MSG_CONTROL
            HAVE_CONNECT_ECONNRESET_BUG
            HAVE_NETINET_IN_SYSTM
            HAVE_TIMEGM
)

if(RAW_SOCKS)
  target_compile_definitions(common INTERFACE USE_RAW_SOCKS)
endif()

target_link_libraries(common INTERFACE pthread m)

if(NOT USE_FAST_LOCK)
  target_compile_definitions(common INTERFACE USE_PTHREAD_MUTEX)
endif()

if(NOT NO_SELECT)
  target_compile_definitions(common INTERFACE HAVE_SELECT)
endif()

if(NOT NO_KQUEUE)
  target_compile_definitions(common INTERFACE HAVE_KQUEUE)
endif()

if(NOT DEFINED RUN_PREFIX)
  set(RUN_PREFIX "/var")
endif()
