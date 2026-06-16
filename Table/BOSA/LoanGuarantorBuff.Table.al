table 59195 "Loan Guarantor Buff"
{
    // version TL2.0

    DrillDownPageID = 50210;
    LookupPageID = 50210;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Member No."; Code[20])
        {
            TableRelation = Member;

            trigger OnValidate()
            begin

            end;
        }
        field(4; "Product Code"; Text[50])
        {
            Editable = false;
        }
        field(5; "Loanee Member No."; Code[20])
        {
            TableRelation = Member;

            trigger OnValidate()
            begin

            end;
        }

        field(10; "Amount To Guarantee"; Decimal)
        {

            trigger OnValidate()
            var
                LGuar: Record "Loan Guarantor";
                Loan: Record "Loan Application";
            begin

            end;
        }
        field(11; "Approved Amount"; Decimal)
        {

            trigger OnValidate()
            var
                LGuar: Record "Loan Guarantor";
                Loan: Record "Loan Application";
            begin

            end;
        }
        field(12; "Approved Date"; Date)
        {


        }

    }

    keys
    {
        key(Key1; "Loan No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        // LoanApplication.Get("Loan No.");
        //LoanApplication.TestField(Status, LoanApplication.Status::New);
    end;

    trigger OnModify()
    begin
        // LoanApplication.Get("Loan No.");
        // LoanApplication.TestField(Status, LoanApplication.Status::New);
    end;

    trigger OnDelete()
    begin
        // LoanApplication.Get("Loan No.");
        // LoanApplication.TestField(Status, LoanApplication.Status::New);
    end;

    local procedure GuarantorAlreadyUsed(): Boolean
    var

    begin
        LoanGuarantor.Reset();
        LoanGuarantor.SetRange("Member No.", "Member No.");
        LoanGuarantor.SetFilter("Loan No.", '<>%1', "Loan No.");
        exit(LoanGuarantor.FindFirst());
    end;

    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountType: Record "Account Type";
        LoanGuarantor: Record "Loan Guarantor";
        LoanApplication: Record "Loan Application";
        GlobalManagement: Codeunit "Global Management";
        Error000: Label '%1 cannot exceed %2';
        Error001: Label 'This account has insufficient balance';
        AccountNotAllowedErr: Label '%1 is not allowed';
        AccountTypeEnum: Enum "Gen. Journal Account Type";
        BOSAManagement: Codeunit "BOSA Management";
        GuarantorAlreadyUsedErr: Label 'This guarantor is already used to guarantee another loan';


}

