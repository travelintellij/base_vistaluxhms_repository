package com.vistaluxhms.util;

import java.util.HashMap;
import java.util.Map;


public interface VistaluxConstants {
    public static final String DEFAULT_DESTINATION_INDIA_CTRY_CODE="IND";
    public static final String DEFAULT_DESTINATION_INDIA_CTRY_NAME="India";
    public static final String DESTINATION_ALL_CTRY_CODE="ALL";
    public static final int DESTINATION_ALL_CITIES = 50000;
    public static final String DEFAULT_PAGE_SIZE="20";

    public static final String BASIC_PRIV_ADMIN="ADMIN";
    public static final String BASIC_PRIV_USER="USER";
    public static final int BASIC_PRIV_ADMIN_CODE=1;
    public static final int BASIC_PRIV_USER_CODE=2;

    public static String WORKLOAD_LEAD_STATUS = "LEAD_STATUS";
    public static final int VIEW_ALL_OPEN_LEADS_WL_STATUS = 100;
    public static final int VIEW_ALL_CLOSED_LEADS_WL_STATUS = 200;
    public static final int VIEW_ALL_LEADS_WL_STATUS = 300;

    public static final int VIEW_WL_OPEN=1000;
    public static final int VIEW_WL_CLOSED=2000;
    static final Map<Integer, String> MEAL_PLANS_MAP = new HashMap<Integer, String>(){
        {
            put(1,"EPAI");
            put(2,"CPAI");
            put(3,"MAPAI");
            put(4,"APAI");
        }
    };

    public static final String PER_GUEST_PER_NIGHT = "PER_GUEST_PER_NIGHT";
    public static final String PER_GUEST_ONE_TIME="PER_GUEST_ONE_TIME";
    public static final String PER_GUEST_PER_DAY="PER_GUEST_PER_DAY";
    public static final String PER_ROOM_ONE_TIME="PER_ROOM_ONE_TIME";
    public static final String PER_ROOM_PER_NIGHT="PER_ROOM_PER_NIGHT";
    public static final String PER_DAY="PER_DAY";
    public static final String PER_NIGHT="PER_NIGHT";
    public static final String ONE_TIME="ONE_TIME";

    public static int EVENT_TYPE_WEDDING = 1;
    public static int EVENT_TYPE_MICE = 2;

    static final Map<Integer, String> CLAIM_TYPE_MAP = new HashMap<Integer, String>(){
        {
            put(1,"Expense");
            put(2,"Incentive");
        }
    };

    static final Map<Integer, String> CLAIM_TRAVEL_MODE = new HashMap<Integer, String>(){
        {
            put(1,"SELF CAR");
            put(2,"TAXI");
            put(3,"FLIGHT");
            put(4,"RENT A CAR");
            put(5,"OTHER");
        }
    };

    public final static String TRAVEL_EXP_STATUS_OBJ = "TRAV_EXP";

    public final static int TRAV_EXP_DEF_STATUS=1;

    public final static int TRAV_EXP_APPROVE_ROLE_ID = 5000;

    public static final Map<Integer, String> DATE_SEL_OPTIONS = new HashMap<Integer, String>(){
        {
            put(1,"Current Month");
            put(2,"Previous Month");
            put(3,"Current Financial Year");
            put(4,"Previous Financial Year");
            put(5,"Apply Date Range");
        }
    };

}
