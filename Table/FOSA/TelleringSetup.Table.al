table 50172 "Tellering Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Teller Transaction Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }

        field(4; "Teller Return Treasury Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; "Teller Close Till Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(10; "Teller Template Name"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(11; "Teller Batch Name"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Teller Template Name"));
        }
        field(160; "Inter Teller Transfer Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(161; "Notification Channel"; Option)
        {
            OptionCaption = 'SMS,Email,Both';
            OptionMembers = SMS,Email,Both;
        }
        field(162; "Notify Member"; Boolean)
        {
        }
        field(18; "Email Template (deposit)"; Text[1024])
        {
        }
        field(19; "SMS Template (deposit)"; Text[1024])
        {
        }

        field(20; "Email Template (reversal)"; Text[1024])
        {
        }

        field(21; "SMS Template (reversal)"; Text[1024])
        {
        }
        field(22; "SMS Template (withdrawal)"; Text[1024])
        {
        }
        field(23; "Email Template (withdrawal)"; Text[1024])
        {
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}