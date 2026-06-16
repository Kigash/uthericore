table 50158 "Dividend Line"
{
    // version TL2.0


    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Member No."; Code[20])
        {
            Editable = false;
            TableRelation = Member;

            trigger OnValidate()
            begin
                Member.GET("Member No.");
                "Member Name" := Member."Full Name";
                "Global Dimension 1 Code" := Member."Global Dimension 1 Code";
            end;
        }
        field(4; "Member Name"; Text[120])
        {
            Editable = false;
        }
        field(5; "Account Type"; Code[20])
        {
            Editable = false;
            TableRelation = "Account Type";
        }
        field(6; "Account No."; Code[20])
        {
            Editable = false;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF Vendor.GET("Account No.") THEN BEGIN
                    "Account No." := Vendor."No.";
                    "Account Name" := Vendor.Name;
                END;
            end;
        }
        field(7; "Account Name"; Text[100])
        {
            Editable = false;
        }
        field(8; "Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(9; "Earning Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Dividend,Interest';
            OptionMembers = " ",Dividend,Interest;
        }
        field(11; "Gross Earning Amount"; Decimal)
        {
            Editable = false;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(13; "Excise Duty Amount"; Decimal)
        {
            Editable = false;
        }
        field(14; "Withholding Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(15; "Commission Amount"; Decimal)
        {
            Editable = false;
        }
        field(16; "Net Earning Amount"; Decimal)
        {
            Editable = false;
        }
        field(17; "Distribution Option"; Option)
        {
            OptionCaption = 'To FOSA,To Loan,To Mpesa';
            OptionMembers = "To FOSA","To Loan","To Mpesa";
        }
        field(18; "Shares Topup Amount"; Decimal)
        {
            Editable = false;
        }
        field(19; "Member Deposits Amount"; Decimal)
        {
            Editable = false;
        }
        field(20; "Share Capital Amount"; Decimal)
        {
            Editable = false;
        }
        field(21; "National ID"; Code[20])
        {
            Editable = false;
        }
        field(22; "Phone No"; Code[50])
        {
            Editable = false;
        }
        field(23; "District"; Code[100])
        {
            Editable = false;
        }
        field(24; "Section"; Code[20])
        {
            Editable = false;
        }
        field(25; "Interest On Deposits Amount"; Decimal)
        {
            Editable = false;
        }
        field(26; "Dividend Share Capital Amount"; Decimal)
        {
            Editable = false;
        }

        field(30; "January"; Decimal)
        {
            Editable = false;
        }
        field(31; "February"; Decimal)
        {
            Editable = false;
        }
        field(32; "March"; Decimal)
        {
            Editable = false;
        }
        field(33; "April"; Decimal)
        {
            Editable = false;
        }
        field(34; "May"; Decimal)
        {
            Editable = false;
        }
        field(35; "June"; Decimal)
        {
            Editable = false;
        }
        field(36; "July"; Decimal)
        {
            Editable = false;
        }
        field(37; "August"; Decimal)
        {
            Editable = false;
        }
        field(38; "September"; Decimal)
        {
            Editable = false;
        }
        field(39; "October"; Decimal)
        {
            Editable = false;
        }
        field(40; "November"; Decimal)
        {
            Editable = false;
        }
        field(41; "December"; Decimal)
        {
            Editable = false;
        }

        field(42; "Deducted Shares Amount"; Decimal)
        {
            Editable = false;
        }
        field(43; "Loan Arrears Deducted Amount"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
}

