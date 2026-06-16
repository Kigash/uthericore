table 50070 "Mobile Banking Activ. Header"
{
    // version TL2.0


    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN
                    "No. Series" := '';
            end;
        }
        field(3; "Member No."; Code[20])
        {
            TableRelation = "Mobile Banking Member";

            trigger OnValidate()
            begin
                MobileBankingMember.GET("Member No.");
                "Member Name" := MobileBankingMember."Member Name";
                "Phone No." := MobileBankingMember."Phone No.";
                "Account No." := MobileBankingMember."Account No.";
                "Account Name" := MobileBankingMember."Account Name";
            end;
        }
        field(4; "Member Name"; Text[50])
        {
            Editable = false;
        }
        field(6; "Current Member Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Active,Frozen';
            OptionMembers = Active,Frozen;
        }
        field(7; "New Member Status"; Option)
        {
            OptionCaption = 'Active,Dormant,Withdrawn,Deceased';
            OptionMembers = Active,Dormant,Withdrawn,Deceased;
        }

        field(9; "Account No."; Code[30])
        {
        }
        field(11; "Account Name"; Text[50])
        {
        }
        field(12; "Phone No."; Code[20])
        {
            TableRelation = "ATM Member";
        }
        field(13; Description; Text[50])
        {
        }
        field(14; "Created Date"; Date)
        {
            Editable = false;
        }
        field(15; "Created By"; Code[30])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(16; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(17; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
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
        IF "No." = '' THEN BEGIN
            "No." := NoSeriesManagement.GetNextNo(MobileBankingSetup."Mobile Banking Activation Nos.");
        END;
        "Created Date" := TODAY;
        "Created By" := USERID;
        Description := Text000 + "No.";
    end;

    var
        MobileBankingSetup: Record "Mobile Banking Setup";
        NoSeriesManagement: Codeunit "No. Series";
        Text000: Label 'Mobile Banking Activation Request ';
        MobileBankingMember: Record "Mobile Banking Member";
}

