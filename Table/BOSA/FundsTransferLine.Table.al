table 56009 "Funds Transfer Line"
{

    fields
    {

        field(1; "Document No."; Code[20])
        {
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; "Account Type"; Option)
        {
            OptionCaption = ' ,Loans,Savinds/Shares,G/L Account';
            OptionMembers = " ",Loans,"Savinds/Shares","G/L Account";
            trigger OnValidate()
            Var
                FTrans: Record "Fund Transfer";
            begin
                if FTrans.Get("Document No.") then begin
                    "Member No." := FTrans."Member No.";
                    "Member Name" := FTrans."Member No.";
                end;
                Clear("Account No.");
                Clear("Account Name");
                Clear("Line Amount");
                Clear("Account Balance");
            end;
        }
        field(5; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = filter("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = filter("Savinds/Shares")) Vendor WHERE("Vendor Type" = filter(1), "Member No." = field("Member No."))
            ELSE
            IF ("Account Type" = filter(Loans)) "Loan Application" where(Posted = filter(true), "Member No." = field("Member No."), "Outstanding Balance" = filter(> 0));

            trigger OnValidate();
            begin

                if "Account Type" = "Account Type"::"Savinds/Shares" then begin
                    Vendor.Get("Account No.");
                    "Account Name" := Vendor.Name;
                    "Account Balance" := GlobalManagement.GetAccountBalance(AccountTypeEnum::Vendor, "Account No.");
                end;
                if "Account Type" = "Account Type"::Loans then begin
                    Customer.Get("Account No.");
                    "Account Name" := Customer.Name;
                    "Account Balance" := GlobalManagement.GetAccountBalance(AccountTypeEnum::Customer, "Account No.");
                end;
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    GLAccount.Get("Account No.");
                    "Account Name" := GLAccount.Name;
                    "Account Balance" := GlobalManagement.GetAccountBalance(AccountTypeEnum::"G/L Account", "Account No.");
                end;
                Description := "Account Name";
            end;


        }
        field(6; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(7; Description; Text[50])
        {
        }

        field(8; "Line Amount"; Decimal)
        {

        }
        field(9; "Account Balance"; Decimal)
        {
            Editable = false;

        }
        field(12; "Member No."; Code[20])
        {
            TableRelation = Member;
            trigger OnValidate()
            var

            begin
                Member.Get("Member No.");
                "Member Name" := Member."Full Name";
                FundsTrans.Get("Document No.");
                if FundsTrans."Transaction Type" = FundsTrans."Destination Account Ownership"::Self then begin
                    FundsTrans.TestField("Member No.");
                    Rec.TestField("Member No.", FundsTrans."Member No.");
                end;
            end;
        }
        field(13; "Member Name"; Text[50])
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



    procedure DeleteRelatedLinks(DocNo: Code[20])
    var

    begin
        ReceiptLine.Reset();
        ReceiptLine.SetRange("Document No.", DocNo);
        ReceiptLine.DeleteAll();
    end;

    procedure ReceiptLinesExist(DocNo: Code[20]): Boolean
    var

    begin
        ReceiptLine.Reset();
        ReceiptLine.SetRange("Document No.", DocNo);
        exit(ReceiptLine.FindFirst());
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        CashManagement: Codeunit "Cash Management";
        VendLedgEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        Vendor: Record Vendor;

        CustLedgerEntry: Record "Cust. Ledger Entry";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        FundsTrans: record "Fund Transfer";
        GlobalSetup: Record "Global Setup";
        ReceiptHeader: Record "Receipt Header";
        ReceiptLine: Record "Receipt Line";
        ReceiptLine2: Record "Receipt Line";
        AccountTypeNotAllowed: Label '%1 is not allowed';
        Member: Record Member;
        GlobalManagement: Codeunit "Global Management";
        AccountTypeEnum: Enum "Gen. Journal Account Type";



}

