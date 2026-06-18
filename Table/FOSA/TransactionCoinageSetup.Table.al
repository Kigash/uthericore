table 50046 "Transaction Coinage Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Transaction No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; Quantity; Integer)
        {
            trigger OnValidate()
            var

            begin

            end;

        }
        field(4; "Coinage Code"; Code[20])
        {
            TableRelation = "Coinage Setup";
            trigger OnValidate()
            var
                CoinageSetup: Record "Coinage Setup";
            begin
                TestField(Quantity);
                CoinageSetup.Reset();
                CoinageSetup.SetRange(Code, "Coinage Code");
                if CoinageSetup.FindFirst() then begin
                    "Coinage Value" := CoinageSetup."Value";
                    "Line Amount" := Quantity * "Coinage Value";
                end;
            end;
        }
        field(5; "Coinage Value"; Decimal)
        {
            Editable = false;
        }
        field(6; "Line Amount"; Decimal)
        {
            Editable = false;

        }
        field(7; "Coinage Source"; Option)
        {
            OptionMembers = Teller,"Teller Return To Bank","Teller Close Till",Treasury,"Treasury Return Bank";
            OptionCaption = 'Teller,Teller Return To Bank,Teller Close Till,Treasury,Treasury Return Bank';

        }

    }

    keys
    {
        key(PK; "Transaction No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        TransactionCoinageSetup: Record "Transaction Coinage Setup";
    begin
        TransactionCoinageSetup.Reset();
        TransactionCoinageSetup.SetRange("Transaction No.", "Transaction No.");
        if TransactionCoinageSetup.FindLast() then
            "Line No." := TransactionCoinageSetup."Line No." + 1;
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