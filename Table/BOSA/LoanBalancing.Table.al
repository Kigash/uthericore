table 59610 "Loan Balancing"
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
            //Editable = false;
            TableRelation = Member;

            trigger OnValidate()
            begin
                Member.GET("Member No.");
                "Member Name" := Member."Full Name";
            end;
        }
        field(3; "Member Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Loan No."; Code[20])
        {
            TableRelation = "Loan Application" where(Posted = filter(true), "Member No." = field("Member No."), "Outstanding Balance" = filter(> 0));
            /*
            "Source Account Type"
            */
            trigger OnValidate()
            begin
                IF LoanApplication.GET("Loan No.") THEN BEGIN
                    Description := LoanApplication.Description;
                    VALIDATE("Member No.", LoanApplication."Member No.");
                END;
                IF Customer.GET("Loan No.") THEN BEGIN
                    Customer.CALCFIELDS("Balance (LCY)");
                    "Outstanding Loan Balance" := Customer."Balance (LCY)";
                END;
            end;
        }
        field(5; Description; Text[50])
        {
            Editable = false;
        }
        field(7; "Outstanding Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(13; "Created By"; Code[30])
        {
            Editable = false;
        }
        field(14; "Created Date"; Date)
        {
            Editable = false;
        }
        field(15; "Created Time"; Time)
        {
            Editable = false;
        }
        field(16; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(20; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(21; Remarks; Text[150])
        {
        }
        field(22; "Approved By"; Code[30])
        {
            Editable = false;
        }
        field(23; "Approved Date"; Date)
        {
            Editable = false;
        }
        field(24; "Approved Time"; Time)
        {
            Editable = false;
        }
        field(26; "Source Account No."; Code[30])
        {
            TableRelation = Vendor WHERE("Member No." = FIELD("Member No."));
            trigger OnValidate()
            begin
                TESTFIELD("Member No.");
                IF Vendor.GET("Source Account No.") THEN
                    "Source Account Name" := Vendor.Name;
                "Source Account Balance" := GlobalManagement.GetAccountBalance(AccountTypeEnum::Vendor, "Source Account No.");
            end;
        }
        field(27; "Source Account Name"; Text[50])
        {
            Editable = false;
        }

        field(28; "Source Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(29; "Loan Account No."; Code[30])
        {
            TableRelation = "Loan Application" WHERE("Member No." = FIELD("Member No."), Posted = filter(true), "Outstanding Balance" = filter(> 0));
            trigger OnValidate()
            begin
                TESTFIELD("Member No.");
                IF Customer.GET("Loan Account No.") THEN
                    "Loan Description" := Customer.Name;
                "Loan Account Balance" := GlobalManagement.GetAccountBalance(AccountTypeEnum::Customer, "Loan Account No.");
            end;
        }
        field(30; "Loan Description"; Text[50])
        {
            Editable = false;
        }

        field(31; "Loan Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(32; "Loan Balancing Amount"; Decimal)
        {
            trigger OnValidate()
            var
                LoanRSetup: Record "Loan Restructuring Setup";
            begin
                Clear("Loan Balancing Charge");
                Clear("Total Deduction Amount");

                LoanRSetup.Get();
                "Loan Balancing Charge" := (LoanRSetup."Loan Balancing %" / 100) * "Loan Balancing Amount";
                "Total Deduction Amount" := "Loan Balancing Amount" + "Loan Balancing Charge";
                if "Loan Balancing Amount" > "Source Account Balance" then
                    Error('Balancing amount cannot exceed loan Source Account Balance');
                if "Loan Balancing Amount" > "Loan Account Balance" then
                    Error('Balancing amount cannot exceed loan balance');
            end;
        }
        field(33; "Posting Date"; Date)
        {
        }
        field(34; "Posted By"; Code[30])
        {
            Editable = false;
        }
        field(35; "Posted Date"; Date)
        {
            Editable = false;
        }
        field(36; "Posted Time"; Time)
        {
            Editable = false;
        }
        field(37; "Loan Balancing Charge"; Decimal)
        {
            Editable = false;
        }
        field(38; "Total Deduction Amount"; Decimal)
        {
            Editable = false;
        }
        field(39; Posted; Boolean)
        {
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
        LoanRestructuringSetup.GET;
        LoanRestructuringSetup.TestField("Loan Restructuring Nos.");
        IF "No." = '' THEN
            "No." := NoSeriesManagement.GetNextNo(LoanRestructuringSetup."Loan Restructuring Nos.");
        "Created Date" := TODAY;
        "Created Time" := TIME;
        "Created By" := USERID;
    end;

    var
        LoanApplication: Record "Loan Application";
        AccountTypeEnum: Enum "Gen. Journal Account Type";
        Vendor: Record Vendor;
        GlobalManagement: Codeunit "Global Management";
        LoanProductType: Record "Loan Product Type";
        Error000: Label '%1 cannot exceed the Maximum Repayment period set for this Loan Product';
        //LoanReschedulingSetup: Record "Loan Rescheduling Setup";
        NoSeriesManagement: Codeunit "No. Series";
        Member: Record Member;
        Customer: Record "Customer";
        Error001: Label 'You must attach supporting documents';
        Error002: Label '%1 cannot exceed the Maximum Interest Rate set for this Loan Product';
        LoanRestructuringSetup: Record "Loan Restructuring Setup";

    procedure ValidateAttachment()
    var
        LoanReschedulingSetup: Record "Loan Rescheduling Setup";
        CBSAttachment: Record "CBS Attachment";
    begin
        LoanReschedulingSetup.GET;
        CBSAttachment.RESET;
        CBSAttachment.SETRANGE("Document No.", "No.");
        IF NOT CBSAttachment.FINDFIRST THEN
            ERROR(Error001);
    end;
}

