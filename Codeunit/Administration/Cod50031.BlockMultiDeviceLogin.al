codeunit 50031 "BlockMultiDeviceLogin"
{
    // Crucial: SingleInstance retains the assigned token in memory for this user's current session
    SingleInstance = true;

    var
        MySessionToken: Guid;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterLogin', '', false, false)]
    local procedure EnforceDeviceToken()
    var
        TokenTracker: Record "User Login Token Tracker";
        ActiveSession: Record "Active Session";
    begin
        // 1. Skip background tasks, web services, and automation tasks
        /*if not (ActiveSession."Client Type" in [ActiveSession."Client Type"::"Web Client", ActiveSession."Client Type"::"Tablet", ActiveSession."Client Type"::"Phone"]) then
            exit;

        // 2. Generate a unique token for THIS browser lifecycle if it doesn't have one yet
        if IsNullGuid(MySessionToken) then
            MySessionToken := CreateGuid();

        // 3. Check if a different device has overridden the token tracker
        if TokenTracker.Get(UserId()) then begin
            if TokenTracker."Current Active Token" <> MySessionToken then begin

                // Locate the older session running on the other device and kill it
                ActiveSession.SetRange("User ID", UserId());
                ActiveSession.SetRange("Client Type", ActiveSession."Client Type"::"Web Client");
                // Do not kill our current session
                ActiveSession.SetFilter("Session ID", '<>%1', SessionId());

                if ActiveSession.FindSet() then begin
                    repeat
                        StopSession(ActiveSession."Session ID", 'Your session was closed because you signed in from a different device.');
                    until ActiveSession.Next() = 0;
                end;

                // Update the tracker so YOUR current device takes priority ownership
                TokenTracker."Current Active Token" := MySessionToken;
                TokenTracker.Modify();
            end;
        end else begin
            // First time logging in globally: insert a brand new tracking record
            TokenTracker.Init();
            TokenTracker."User ID" := UserId();
            TokenTracker."Current Active Token" := MySessionToken;
            TokenTracker.Insert();
        end;*/
    end;

}

