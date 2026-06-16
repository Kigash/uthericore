table 50038 "Member Contribution"
{
    // version TL2.0


    fields
    {
        field(1; "Application No."; Code[20])
        {
        }
        field(2; "Account Type"; Code[20])
        {
            TableRelation = "Account Type";
            trigger OnValidate()
            var
                AccountType: Record "Account Type";
            begin
                if AccountType.Get("Account Type") then
                    Description := AccountType.Description;
            end;


        }
        field(3; Description; Text[50])
        {
            Editable = false;
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "No."; Code[20])
        {

        }

        field(6; "Member No."; Code[20]) { }
        field(7; "Account Category"; Code[20]) { }
        field(8; "Account No."; Code[20]) { }
        field(9; "Start Date"; Date) { }
        field(10; "End Date"; Date) { }



    }

    keys
    {
        key(Key1; "Application No.", "Account Type", "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

