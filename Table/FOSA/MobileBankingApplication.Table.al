table 50067 "Mobile Banking Application"
{
    // version TL2.0

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN
                    "No. Series" := '';
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Member;

            trigger OnValidate()
            var
                MobileMemb: Record "Mobile Banking Member";
                MobileApp: Record "Mobile Banking Application";
            begin

                Member.GET("Member No.");
                "Member Name" := Member."Full Name";
                Member.TESTFIELD("Phone No.");
                "Phone No." := Member."Phone No.";

            end;
        }
        field(3; "Member Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Account No."; Code[20])
        {
            // TableRelation = Vendor WHERE("Member No." = FIELD("Member No."));

            trigger OnValidate()
            begin
                IF Vendor.GET("Account No.") THEN
                    "Account Name" := Vendor.Name;
            end;
        }
        field(5; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(6; "Created Date"; Date)
        {
            Editable = false;
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(8; "Created By"; Code[30])
        {
            Editable = false;
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; "Phone No."; Code[20])
        {
            Editable = false;
        }
        field(11; "Service Type"; Option)
        {
            OptionCaption = 'Mobile Banking,Agency Banking';
            OptionMembers = "Mobile Banking","Agency Banking";
        }
        field(12; "SMS Alert on"; Option)
        {
            OptionCaption = ' ,Debit,Credit,Both';
            OptionMembers = " ",Debit,Credit,Both;
        }
        field(13; "E-Mail Alert on"; Option)
        {
            OptionCaption = ' ,Debit,Credit,Both';
            OptionMembers = " ",Debit,Credit,Both;
        }
        field(14; "Created Time"; Time)
        {
            Editable = false;
        }
        field(15; "Approved Time"; Time)
        {
            Editable = false;
        }
        field(16; "Approved By"; Code[30])
        {
            Editable = false;
        }
        field(18; "Approved Date"; Date)
        {
            Editable = false;
        }
        field(19; "Last Modified Date"; Date)
        {
            Editable = false;
        }
        field(20; "Last Modified Time"; Time)
        {
            Editable = false;
        }
        field(21; "Last Modified By"; Code[30])
        {
            Editable = false;
        }
        field(22; "Created By Host IP"; Code[30])
        {
            Editable = false;
        }
        field(23; "Approved By Host IP"; Code[30])
        {
            Editable = false;
        }
        field(24; "Created By Host Name"; Code[30])
        {
            Editable = false;
        }
        field(25; "Created By Host MAC"; Code[30])
        {
            Editable = false;
        }
        field(26; "Last Modified By Host IP"; Code[30])
        {
            Editable = false;
        }
        field(27; "Last Modified By Host Name"; Code[30])
        {
            Editable = false;
        }
        field(28; "Last Modified By Host MAC"; Code[30])
        {
            Editable = false;
        }

        field(30; "Approved By Host Name"; Code[30])
        {
            Editable = false;
        }
        field(31; "Approved By Host MAC"; Code[30])
        {
            Editable = false;
        }
        field(32; "Updated On Portal"; Boolean)
        {
            Editable = false;
        }
        field(33; "Uploaded from Excel"; Boolean)
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

    trigger OnInsert()
    begin
        MobileBankingSetup.GET;
        IF "No." = '' THEN
            "No." := NoSeriesManagement.GetNextNo(MobileBankingSetup."Mobile Banking Appl. Nos.");
        GlobalManagement.GetHostInfo(HostName, HostIP, HostMac);
        "Created By" := USERID;
        "Created By Host IP" := HostIP;
        "Created By Host MAC" := HostMac;
        "Created By Host Name" := HostName;
        "Created Date" := TODAY;
        "Created Time" := TIME;
    end;

    trigger OnModify()
    begin
        GlobalManagement.GetHostInfo(HostName, HostIP, HostMac);
        "Last Modified By Host IP" := HostIP;
        "Last Modified By Host MAC" := HostMac;
        "Last Modified By Host Name" := HostName;
        "Last Modified Date" := TODAY;
        "Last Modified Time" := TIME;
        "Last Modified By" := USERID;
    end;



    var
        Member: Record Member;
        Vendor: Record Vendor;
        MobileBankingSetup: Record "Mobile Banking Setup";
        NoSeriesManagement: Codeunit "No. Series";
        HostMac: Code[20];
        HostName: Code[20];
        HostIP: Code[20];
        GlobalManagement: Codeunit "Global Management";
}

