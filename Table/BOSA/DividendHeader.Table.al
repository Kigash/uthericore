table 50157 "Dividend Header"
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
        field(2; Description; Text[50])
        {

        }
        field(3; "Period Code"; Code[20])
        {

        }
        field(7; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Dividend Line"."Gross Earning Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(9; "Created By"; Code[30])
        {
            Editable = false;
        }
        field(10; "Created Date"; Date)
        {
            Editable = false;
        }
        field(11; "Created Time"; Time)
        {
            Editable = false;
        }
        field(12; "Approved By"; Code[30])
        {
            Editable = false;
        }
        field(13; "Approved Date"; Date)
        {
            Editable = false;
        }
        field(14; "Approved Time"; Time)
        {
            Editable = false;
        }
        field(15; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(16; Posted; Boolean)
        {
            Editable = false;
        }
        field(17; "Calculation End Date"; Date)
        {
            trigger OnValidate()
            begin

                Description := STRSUBSTNO(Text000, DATE2DMY("Calculation End Date", 3));
                "Period Code" := FORMAT(DATE2DMY("Calculation End Date", 3));
            end;
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
        DividendSetup.GET;

        IF "No." = '' THEN BEGIN
            "No." := NoSeriesManagement.GetNextNo(DividendSetup."Dividend Nos.");
        END;
        "Created Date" := TODAY;
        "Created Time" := TIME;
        "Created By" := USERID;
    end;

    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
        DividendSetup: Record "Dividend Setup";
        NoSeriesManagement: Codeunit "No. Series";
        BOSAManagement: Codeunit "BOSA Management";
        Text000: Label 'Dividend for Year %1';
}

