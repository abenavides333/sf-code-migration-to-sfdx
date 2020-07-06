global with sharing class DreamHouseSampleDataController {

    @RemoteAction
    global static void deleteAll() {
        delete [SELECT Id FROM Property__c];
        delete [SELECT Id FROM Broker__c];
    }

    public static String getHelloWorld() {
        return 'Hello World!';
    }
}