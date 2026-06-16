table 54608 "Bulk SMS To Members"
{

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;
        }
        field(2; "SMS Date"; Date)
        {
        }
        field(14; Category; Option)
        {
            OptionCaption = ' ,All,Individual,Group,Company,Joint,Junior';
            OptionMembers = " ",All,Individual,Group,Company,Joint,Junior;
        }
        field(16; "No. Series"; Code[20])
        {
        }
        field(22; "Created By"; Code[90])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(23; "SMS Sent"; Boolean)
        {
        }
        field(24; "SMS Text"; Blob)
        {
        }
        field(25; "Source Code"; Code[20])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        CBSSetup.GET;
        if "No." = '' then
            //"No." := NoSeriesManagement.GetNextNo(CBSSetup."Bulk SMS Nos", 0D, true);
          "No." := NoSeriesManagement.GetNextNo(CBSSetup."Bulk SMS Nos");
        InsertMemb("No.");
        "Created By" := USERID;
    end;

    var
        NoSeriesManagement: Codeunit "No. Series";
        CBSSetup: Record "Global Setup";

    local procedure InsertMemb(DocNo: Code[10]);
    var
        Vehicles: Record "Vehicle Register";
        Memb: Record Member;
        BulKSMSLine: Record "Bulk SMS Line";
        LineNo: Integer;
    begin
        LineNo := 1000;

        Memb.RESET;
        Memb.SETFILTER("Phone No.", '<>%1', '');
        if Memb.FINDSET then begin
            repeat
                BulKSMSLine.INIT;
                BulKSMSLine."Document No" := DocNo;
                BulKSMSLine."Line No" := LineNo;
                BulKSMSLine."Owner Member No" := Memb."No.";
                BulKSMSLine."Owner Name" := Memb."Full Name";
                BulKSMSLine."Owner Phone No" := Memb."Phone No.";
                BulKSMSLine.INSERT;
                LineNo += 1000;
            until Memb.NEXT = 0;
        end
    end;

    procedure SetSMSTemplate(NewSMSTemplate: Text);
    var
        OStream: OutStream;
        Memb: Record Member;
    begin
        CLEAR("SMS Text");
        IF NewSMSTemplate = '' THEN
            EXIT;
        "SMS Text".CREATEOUTSTREAM(OStream);
        OStream.WRITE(NewSMSTemplate);
        MODIFY;
    end;

    procedure GetSMSTemplate(): Text;
    var
        IStream: InStream;
        SMSText: Text;
    begin
        CALCFIELDS("SMS Text");
        IF NOT "SMS Text".HASVALUE THEN
            EXIT;
        "SMS Text".CREATEINSTREAM(IStream);
        IStream.READ(SMSText);
        EXIT(SMSText);
    end;
}

