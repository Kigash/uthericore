table 50043 "Teller Transaction Line"
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
        field(3; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = FILTER(Loans)) "Loan Application" WHERE("Member No." = FIELD("Member No."), "Outstanding Balance" = filter(> 0))
            ELSE
            IF ("Account Type" = FILTER("Savings/ shares")) Vendor WHERE("Member No." = FIELD("Member No."))
            ELSE
            IF ("Account Type" = FILTER("G/L Account")) "G/L Account" WHERE("Account Category" = filter(Income));
            trigger OnValidate()
            begin
                //ClearAmounts();
                Clear("Line Amount");
                //ValidateTransactionHeader;
                ValidateAccountType();
                ValidateAccountNo();
                IF "Account Type" = "Account Type"::"Savings/ shares" THEN BEGIN
                    IF Vendor.GET("Account No.") THEN begin
                        "Account Name" := Vendor.Name;
                        // "Member No." := Vendor."Member No.";
                        // "Member Name" := Vendor."Member Name";
                    end;
                end;

                IF "Account Type" = "Account Type"::Loans THEN BEGIN
                    IF Customer.GET("Account No.") THEN begin
                        "Account Name" := Customer.Name;
                        // "Member No." := Customer."Member No.";
                        // "Member Name" := Customer."Member Name";
                    end;
                END;
                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    IF GLAccount.GET("Account No.") THEN begin
                        "Account Name" := GLAccount.Name;
                        // "Member No." := Customer."Member No.";
                        // "Member Name" := Customer."Member Name";
                    end;
                END;
            end;
        }
        field(4; "Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(5; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Tellering: Codeunit "Tellering & Treasury";
                TransType: Record "Transaction -Type";
            begin
                //ClearAmounts();
                Clear("Transaction Charge");
                Tellering.GetTransactionCharges("Transaction Type", "Line Amount", "Transaction Charge");
                ValidateAccountNo();
                TransType.GET("Transaction Type");
                If (TransType.Type = TransType.Type::"Teller Cash Withdrawal") or (TransType.Type = TransType.Type::"Teller Cheque Withdrawal") then begin
                    if ("Line Amount" + "Transaction Charge") > "Withdrawable Amount" then
                        Error('Line Amount and Transaction Charge cannot be greater than Withdrawable Amount');
                end;
                ValidateTotalAmount();
            end;
        }

        field(7; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'Savings/ shares,Loans,G/L Account';
            OptionMembers = "Savings/ shares",Loans,"G/L Account";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //ValidateTransactionHeader();
                ValidateAccountType();

            end;
        }
        field(8; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Member;
            trigger OnValidate()
            var

            begin
                //ValidateTransactionHeader();
                //"Account No." := '';
                //"Account Name" := '';
                //Member.GET("Member No.");
                //"Member Name" := Member."Full Name";
                DeleteRelatedLinks(xRec."Member No.");
                //CalculateMemberStatistics();

            end;


        }
        field(9; "Member Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(10; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction -Type" where("Application Area" = filter(Teller));
            trigger OnValidate()
            var
                TransType: Record "Transaction -Type";
            begin
                //ClearAmounts();

                Clear("Account No.");
                Clear("Account Name");
                Clear("Account Type");
                Clear("Bank Acc No");
                Clear("Is Bank Deposit");
                Clear("Is Cheque");
                Clear("Cheque No");
                Clear("Transaction Charge");

                Clear("Line Amount");
                Clear("Debit Amount");
                Clear("Credit Amount");

                TellerUserSetup.Get(UserId);
                TransactionType.Get("Transaction Type");
                if TransactionType."Application Area" = TransactionType."Application Area"::Teller then begin
                    if TransactionType.Type = TransactionType.Type::"Teller Cash Withdrawal" then begin
                        if not TellerUserSetup."Withdrawal Allowed" then
                            Error(WithdrawalNotAllowedErr1);

                    end;
                    if TransactionType.Type = TransactionType.Type::"Teller Cash Deposit" then begin
                        if not TellerUserSetup."Deposit Allowed" then
                            Error(DepositNotAllowedErr1);
                    end;
                end;
                TellerTransactionHeader.Get("Transaction No.");
                "Member No." := TellerTransactionHeader."Member No.";
                "Member Name" := TellerTransactionHeader."Member Name";
                Clear("Is Cheque");
                if TransType.Get("Transaction Type") then begin
                    if (TransType.Type = TransType.Type::"Teller Cheque Deposit") or (TransType.Type = TransType.Type::"Teller Cheque Withdrawal") then begin
                        "Is Cheque" := true
                    end else begin
                        "Is Cheque" := false;
                    end;
                    if (TransType.Type = TransType.Type::"Bank Deposit") then begin
                        "Is Bank Deposit" := true
                    end else begin
                        "Is Bank Deposit" := false;
                    end;
                end;
            end;
        }
        field(11; "Debit Amount"; Decimal)
        {
            trigger OnValidate()
            var
            begin
            end;
        }
        field(12; "Credit Amount"; Decimal)
        {
            trigger OnValidate()
            var
            begin
            end;
        }
        field(13; "Transaction Charge"; Decimal)
        {
            trigger OnValidate()
            var
            begin
            end;
        }
        field(14; "Cheque No"; Code[100])
        {

        }
        field(15; "Is Cheque"; Boolean)
        {

        }
        field(16; "Bank Acc No"; Code[100])
        {
            TableRelation = "Bank Account" Where("Account Type" = filter(0));
        }
        field(17; "Is Bank Deposit"; Boolean)
        {

        }
        field(18; "Withdrawable Amount"; Decimal)
        {

        }
    }

    keys
    {
        key(PK; "Transaction No.", "Line No.")
        {
            Clustered = true;
        }
    }
    local procedure ClearAmounts()
    begin
        Clear("Account No.");
        Clear("Account Name");
        Clear("Account Type");
        Clear("Bank Acc No");
        Clear("Is Bank Deposit");
        Clear("Is Cheque");
        Clear("Cheque No");
        Clear("Transaction Charge");

        Clear("Line Amount");
        Clear("Debit Amount");
        Clear("Credit Amount");
    end;

    local procedure ValidateTotalAmount()
    var
        myInt: Integer;
    begin
        TellerTransactionHeader.Get("Transaction No.");
        TellerTransactionHeader.CalcFields("Total Line Amount");
        TellerUserSetup.Get(TellerTransactionHeader."Teller User ID");
        if TellerTransactionHeader."Total Line Amount" + "Line Amount" >= TellerUserSetup."Withdrawal Limit (Approval)" then begin
            if Confirm(RequireApprovalConfirmMsg, true) then begin
                IF ApprovalsMgmt.CheckTellerTransactionApprovalPossible(TellerTransactionHeader) THEN begin
                    ApprovalsMgmt.OnSendTellerTransactionForApproval(TellerTransactionHeader);

                end;
            end else
                exit;
        end;
    end;

    local procedure ValidateTransactionHeader()
    var
        myInt: Integer;
    begin
        TellerTransactionHeader.Get("Transaction No.");
        TellerTransactionHeader.TestField("Transaction Amount");
        //TellerTransactionHeader.TestField(Description);
        //TellerTransactionHeader.TestField("Transaction Type");
    end;

    local procedure ValidateAccountType()
    var

        OptionValue: Text;
    begin

        OPtionValue := Format("Account Type");//GlobalManagement.GetOptionValues(50043, 7);

        TellerTransactionHeader.Get("Transaction No.");
        TransactionType.Get("Transaction Type");
        case TransactionType.Type of
            TransactionType.Type::"Teller Cash Deposit":
                begin

                end;
            TransactionType.Type::"Teller Cheque Deposit":
                begin

                end;
            TransactionType.Type::"Teller Cash Withdrawal":
                begin
                    if (("Account Type" = "Account Type"::Loans) or ("Account Type" = "Account Type"::"G/L Account")) then
                        Error(ValidateAccountTypeErrMsg, OptionValue, TellerTransactionHeader."Transaction Type");
                end;
            TransactionType.Type::"Teller Cheque Withdrawal":
                begin
                    if (("Account Type" = "Account Type"::Loans) or ("Account Type" = "Account Type"::"G/L Account")) then
                        Error(ValidateAccountTypeErrMsg, OptionValue, TellerTransactionHeader."Transaction Type");
                end;
        end;
    end;

    local procedure ValidateAccountNo()
    var
        myInt: Integer;
        TransactionCharge: Record "Transaction Charge";
    begin
        TestField("Member No.");
        TellerTransactionHeader.Get("Transaction No.");
        TransactionType.Get("Transaction Type");
        case TransactionType.Type of
            TransactionType.Type::"Teller Cash Deposit":
                begin
                    if "Account Type" = "Account Type"::"Savings/ shares" then begin
                        Vendor.get("Account No.");
                        AccountType.Get(Vendor."Account Type");

                        if not AccountType."Allow Deposit" then
                            Error(DepositNotAllowedErr);
                        if "Line Amount" > AccountType."Maximum Deposit Amount" then
                            Error(DepositExceededErr, FieldCaption("Line Amount"));
                    end;
                    "Credit Amount" := "Line Amount";
                end;
            TransactionType.Type::"Teller Cheque Deposit":
                begin
                    if "Account Type" = "Account Type"::"Savings/ shares" then begin
                        Vendor.get("Account No.");
                        AccountType.Get(Vendor."Account Type");

                        if not AccountType."Allow Deposit" then
                            Error(DepositNotAllowedErr);
                        if "Line Amount" > AccountType."Maximum Deposit Amount" then
                            Error(DepositExceededErr, FieldCaption("Line Amount"));
                    end;
                    "Credit Amount" := "Line Amount";
                end;
            TransactionType.Type::"Bank Deposit":
                begin
                    if "Account Type" = "Account Type"::"Savings/ shares" then begin
                        Vendor.get("Account No.");
                        AccountType.Get(Vendor."Account Type");

                        if not AccountType."Allow Deposit" then
                            Error(DepositNotAllowedErr);
                        if "Line Amount" > AccountType."Maximum Deposit Amount" then
                            Error(DepositExceededErr, FieldCaption("Line Amount"));
                    end;
                    "Credit Amount" := "Line Amount";
                end;
            TransactionType.Type::"Teller Cash Withdrawal":
                begin
                    if "Account Type" = "Account Type"::"Savings/ shares" then begin
                        Vendor.get("Account No.");
                        Vendor.CalcFields(Balance, "Withheld Sep10th 2024 Balance", "Deposits From Sep10th 2024 Balance");
                        AccountType.Get(Vendor."Account Type");
                        "Withdrawable Amount" := (Vendor.Balance - Vendor."Withheld Sep10th 2024 Balance" - AccountType."Minimum Balance");
                        if not AccountType."Allow Withdrawal" then
                            Error(WithdrawalNotAllowedErr);
                        if "Line Amount" > AccountType."Maximum Withdrawal Amount" then
                            Error(WithdrawalExceededErr, FieldCaption("Line Amount"));
                    end;
                    "Debit Amount" := "Line Amount";
                end;
            TransactionType.Type::"Teller Cheque Withdrawal":
                begin
                    if "Account Type" = "Account Type"::"Savings/ shares" then begin
                        Vendor.get("Account No.");
                        Vendor.CalcFields(Balance, "Withheld Sep10th 2024 Balance", "Deposits From Sep10th 2024 Balance");
                        AccountType.Get(Vendor."Account Type");
                        "Withdrawable Amount" := (Vendor.Balance - Vendor."Withheld Sep10th 2024 Balance" - AccountType."Minimum Balance");
                        if not AccountType."Allow Withdrawal" then
                            Error(WithdrawalNotAllowedErr);
                        if "Line Amount" > AccountType."Maximum Withdrawal Amount" then
                            Error(WithdrawalExceededErr, FieldCaption("Line Amount"));

                    end;
                    "Debit Amount" := "Line Amount";
                end;
        end;

        /*TransactionCharge.Reset();
        TransactionCharge.SetRange("Transaction Type Code", TransactionType.Code);
        if TransactionCharge.FindSet() then begin
            repeat
                if (("Line Amount" >= TransactionCharge."Minimum Amount") and ("Line Amount" <= TransactionCharge."Maximum Amount")) then begin
                    "Transaction Charge" += TransactionCharge."Settlement Amount  (SACCO)";
                end;
            until TransactionCharge.Next() = 0;
        end;*/
    end;

    procedure CalculateMemberStatistics()
    var
        i: Integer;
    begin
        i := 0;
        Customer.Reset();
        Customer.SetRange("Member No.", "Member No.");
        if Customer.FindSet() then begin
            repeat
                Customer.CalcFields("Balance (LCY)");
                CreateTellerMemberStatistics(Customer.Name, Customer."Balance (LCY)");
            until Customer.Next() = 0;
        end;

        AccountType.Reset();
        //AccountType.SetRange(Type, AccountType.Type::"Share Capital");
        if AccountType.FindSet() then begin
            repeat
                Vendor.Reset();
                Vendor.SetRange("Member No.", "Member No.");
                Vendor.SetRange("Account Type", AccountType.Code);
                if Vendor.FindFirst() then begin
                    Vendor.CalcFields("Balance (LCY)");
                    CreateTellerMemberStatistics(Vendor.Name, abs(Vendor."Balance (LCY)"));
                end;
            until AccountType.Next() = 0
        end;
        /*TellerTransactionLine.Reset();
        TellerTransactionLine.SetRange("Account Type", TellerTransactionLine."Account Type"::"G/L Account");
        TellerTransactionLine.SetRange("Member No.", "Member No.");
        TellerTransactionLine.setrange("Account No.", '003');
        TellerTransactionLine.CalcSums("Line Amount");
        CreateTellerMemberStatistics('Service Charge', TellerTransactionLine."Line Amount")*/
    end;

    local procedure CreateTellerMemberStatistics(Description: Text[50]; Amount: Decimal)
    var
        TellerMemberStatistic2: Record "Teller Member Statistic";
        LineNo: Integer;
    begin
        TellerMemberStatistic.Init();
        TellerMemberStatistic2.Reset();
        TellerMemberStatistic2.SetRange("Transaction No.", "Transaction No.");
        if TellerMemberStatistic2.FindLast() then
            LineNo := TellerMemberStatistic2."Line No."
        else
            LineNo := 0;
        TellerMemberStatistic."Transaction No." := "Transaction No.";
        TellerMemberStatistic."Line No." := LineNo + 10000;
        TellerMemberStatistic."Member No." := "Member No.";
        TellerMemberStatistic.Description := Description;
        TellerMemberStatistic.Balance := Amount;
        TellerMemberStatistic.Insert();
    end;

    local procedure DeleteRelatedLinks(MemberNo: Code[20])
    var
        myInt: Integer;
    begin
        TellerMemberStatistic.Reset();
        TellerMemberStatistic.SetRange("Transaction No.", "Transaction No.");
        TellerMemberStatistic.SetRange("Member No.", MemberNo);
        TellerMemberStatistic.DeleteAll();
    end;

    var
        Vendor: Record Vendor;
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        Member: Record Member;
        TellerUserSetup: Record "Teller User Setup";
        TellerTransactionHeader: Record "Teller Transaction Header";
        RequireApprovalConfirmMsg: Label 'This transaction require approval, Do you wish to send for approval?';
        ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
        TransactionType: Record "Transaction -Type";
        ValidateAccountTypeErrMsg: Label 'Option %1 is not allowed for Transaction Type %2';
        GlobalManagement: Codeunit "Global Management";
        AccountType: Record "Account Type";
        WithdrawalNotAllowedErr: Label 'Withdrawal is not allowed for this account';
        WithdrawalExceededErr: Label '%1 has exceeded the Maximum Withdrawal allowed';
        WithdrawalNotAllowedErr1: Label 'Withdrawal service is not allowed for this Teller';
        DepositNotAllowedErr1: Label 'Deposit service is not allowed for this Teller';
        DepositNotAllowedErr: Label 'Deposit is not allowed for this account';
        DepositExceededErr: Label '%1 has  exceeded the Maximum Deposit allowed';
        TellerTransactionLine: Record "Teller Transaction Line";

        TellerMemberStatistic: Record "Teller Member Statistic";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        DeleteRelatedLinks("Member No.");
    end;

    trigger OnRename()
    begin

    end;

}