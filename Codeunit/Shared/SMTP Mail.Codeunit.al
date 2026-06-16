codeunit 50500 "SMTP Mail"
{
    // Minimal compile-time stub for SMTP Mail signatures used across the project.
    // No real SMTP activity is performed here.

    var
        Setup: Record "SMTP Mail Setup";
        CCList: List of [Text];

    procedure CreateMessage(SenderName: Text; SenderEmail: Text; Recipient: Text; Subject: Text; Body: Text; IsHTML: Boolean): Text
    begin
        // Return a dummy message id. The real implementation would create an SMTP message object.
        exit('MSG-' + FORMAT(CREATEGUID()));
    end;

    procedure AddCC(Recipients: List of [Text])
    var
        i: Integer;
        item: Text;
    begin
        // append all recipients from the provided list into the local CCList
        for i := 1 to Recipients.Count() do begin
            item := Recipients.Get(i);
            CCList.Add(item);
        end;
    end;

    procedure AddCC(Recipient: Text)
    begin
        CCList.Add(Recipient);
    end;

    procedure AddBCC(Recipient: Text)
    begin
        // No-op for stub
    end;

    procedure Send()
    begin
        // no-op
    end;

    procedure Send(Recipient: Text; Subject: Text; Body: Text)
    begin
        // no-op overload used in some places
    end;

    procedure SetupExists(): Boolean
    begin
        exit(Setup.FindFirst());
    end;
}

