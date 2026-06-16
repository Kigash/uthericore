codeunit 50029 "Teller Management"
{
    trigger OnRun()
    begin

    end;

    Procedure GetSavingsAccounts(VAR MobilePhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
        Found: Boolean;
    begin
        Member.RESET;
        Member.SETRANGE("Phone No.", MobilePhoneNo);
        IF NOT Member.FIND('-') THEN BEGIN
            ResponseCode := '14';
            ErrorMessage := 'Member does not exist';
            EXIT;
        END else begin
            IF Member.Status <> Member.Status::Active THEN BEGIN
                ResponseCode := '14';
                ErrorMessage := 'Member not active';
                EXIT;
            END;
        end;
        Found := false;
        Vendor.RESET;
        Vendor.SETRANGE("Member No.", Member."No.");
        IF NOT Vendor.FIND('-') THEN BEGIN
            ResponseCode := '14';
            ErrorMessage := 'Member has no accounts attached';
            EXIT;
        END ELSE BEGIN
            ResponseCode := '000';
            ResponseMessage := '{"member" :{';
            ResponseMessage +=
                            '"name" :"' + Member."Full Name" +
                            '","nationalId" : "' + Member."National ID" +
                            '"}, "accounts" :[';

            REPEAT
                Vendor.CalcFields(Balance);
                accountTypes.RESET;
                accountTypes.SETRANGE(Code, Vendor."Account Type");
                accountTypes.SETRANGE(Type, accountTypes.Type::Savings);
                AccountTypes.SetFilter("Sub Type", '<>%1', AccountTypes."Sub Type"::Virtual);
                IF accountTypes.FINDFIRST THEN BEGIN
                    Found := true;
                    ResponseMessage +=
                                    '{' +
                                        '"accountNo": "' + Vendor."No." +
                                        '","accountName": "' + Vendor.Name +
                                        '","canWithdraw" : "' + FORMAT(accountTypes."Allow Withdrawal") +
                                        '","canDeposit": "' + FORMAT(accountTypes."Allow Deposit") +
                                        '","isLoanAccount": "' + FORMAT(FALSE) +
                                        '","isNWD": "' + FORMAT(FALSE) +
                                        '","isShareCapital": "' + FORMAT(FALSE) +
                                        '","isSavingsAccount": "' + FORMAT(TRUE) +
                                        '","balance" : "' + FORMAT(Vendor.Balance) +
                                        '","maxWithdrawable" : "' + FORMAT(accountTypes."Maximum No. of Withdrawal") +
                                    '"},';

                END;
            UNTIL Vendor.NEXT = 0;
            if Found = true then
                ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
            ResponseMessage += ']}';
            EXIT;
        end;
    end;

    Procedure GetNWDAccounts(VAR MobilePhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
        Found: Boolean;

    begin
        Member.RESET;
        Member.SETRANGE("Phone No.", MobilePhoneNo);
        IF NOT Member.FIND('-') THEN BEGIN
            ResponseCode := '14';
            ErrorMessage := 'Member does not exist';
            EXIT;
        END else begin
            IF Member.Status <> Member.Status::Active THEN BEGIN
                ResponseCode := '14';
                ErrorMessage := 'Member not active';
                EXIT;
            END;
        end;
        Found := false;
        Vendor.RESET;
        Vendor.SETRANGE("Member No.", Member."No.");
        IF NOT Vendor.FIND('-') THEN BEGIN
            ResponseCode := '14';
            ErrorMessage := 'Member has no accounts attached';
            EXIT;
        END ELSE BEGIN
            ResponseCode := '000';
            ResponseMessage := '{"member" :{';
            ResponseMessage +=
                            '"name" :"' + Member."Full Name" +
                            '","nationalId" : "' + Member."National ID" +
                            '"}, "accounts" :[';

            REPEAT
                Vendor.CalcFields(Balance);
                accountTypes.RESET;
                accountTypes.SETRANGE(Code, Vendor."Account Type");
                accountTypes.SetFilter(Type, '%1|%2|%3', accountTypes.Type::"Call Deposit", AccountTypes.Type::"Fixed Deposit", AccountTypes.Type::"Member Deposit");
                IF accountTypes.FINDFIRST THEN BEGIN
                    Found := true;
                    ResponseMessage +=
                                    '{' +
                                        '"accountNo": "' + Vendor."No." +
                                        '","accountName": "' + Vendor.Name +
                                        '","canWithdraw" : "' + FORMAT(accountTypes."Allow Withdrawal") +
                                        '","canDeposit": "' + FORMAT(accountTypes."Allow Deposit") +
                                        '","isLoanAccount": "' + FORMAT(FALSE) +
                                        '","isNWD": "' + FORMAT(TRUE) +
                                        '","isShareCapital": "' + FORMAT(FALSE) +
                                        '","isSavingsAccount": "' + FORMAT(FALSE) +
                                        '","balance" : "' + FORMAT(Vendor.Balance) +
                                        '","maxWithdrawable" : "' + FORMAT(accountTypes."Maximum No. of Withdrawal") +
                                    '"},';

                END;
            UNTIL Vendor.NEXT = 0;
            if Found = true then
                ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
            ResponseMessage += ']}';
            EXIT;
        end;
    end;

    Procedure GetShareCapitalAccounts(VAR MobilePhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
        Found: Boolean;

    begin
        Member.RESET;
        Member.SETRANGE("Phone No.", MobilePhoneNo);
        IF NOT Member.FIND('-') THEN BEGIN
            ResponseCode := '14';
            ErrorMessage := 'Member does not exist';
            EXIT;
        END else begin
            IF Member.Status <> Member.Status::Active THEN BEGIN
                ResponseCode := '14';
                ErrorMessage := 'Member not active';
                EXIT;
            END;
        end;
        Vendor.RESET;
        Vendor.SETRANGE("Member No.", Member."No.");
        IF NOT Vendor.FIND('-') THEN BEGIN
            ResponseCode := '14';
            ErrorMessage := 'Member has no accounts attached';
            EXIT;
        END ELSE BEGIN
            Found := false;
            ResponseCode := '000';
            ResponseMessage := '{"member" :{';
            ResponseMessage +=
                            '"name" :"' + Member."Full Name" +
                            '","nationalId" : "' + Member."National ID" +
                            '"}, "accounts" :[';

            REPEAT
                Vendor.CalcFields(Balance);
                accountTypes.RESET;
                accountTypes.SETRANGE(Code, Vendor."Account Type");
                accountTypes.SETRANGE(Type, accountTypes.Type::"Share Capital");
                IF accountTypes.FINDFIRST THEN BEGIN
                    Found := true;
                    ResponseMessage +=
                                    '{' +
                                        '"accountNo": "' + Vendor."No." +
                                        '","accountName": "' + Vendor.Name +
                                        '","canWithdraw" : "' + FORMAT(accountTypes."Allow Withdrawal") +
                                        '","canDeposit": "' + FORMAT(accountTypes."Allow Deposit") +
                                        '","isLoanAccount": "' + FORMAT(FALSE) +
                                        '","isNWD": "' + FORMAT(FALSE) +
                                        '","isShareCapital": "' + FORMAT(TRUE) +
                                        '","isSavingsAccount": "' + FORMAT(FALSE) +
                                        '","balance" : "' + FORMAT(Vendor.Balance) +
                                        '","maxWithdrawable" : "' + FORMAT(accountTypes."Maximum No. of Withdrawal") +
                                    '"},';

                END;
            UNTIL Vendor.NEXT = 0;
            if Found = true then
                ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
            ResponseMessage += ']}';
            EXIT;
        end;
    end;

    procedure TellerOpenCloseTill(OpenCTill: Record "Teller Close Till")
    var
        TellerUserSetup: Record "Teller User Setup";
    begin
        if TellerUserSetup.Get(OpenCTill."Teller User ID") then begin
            if OpenCTill."Action Type" = OpenCTill."Action Type"::"Close Till" then
                TellerUserSetup.Active := false;
            if OpenCTill."Action Type" = OpenCTill."Action Type"::"Open Till" then
                TellerUserSetup.Active := true;
            TellerUserSetup.Modify();
        end;
    end;

    procedure GetLoanAccounts(VAR MobilePhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    var
        Member: Record Member;
        //CustomerRec: Record Customer;
        hasaccounts: Boolean;
        LoanProductTypes: Record "Loan Product Type";
        LoanApplication: Record "Loan Application";
        InstallmentAmount: Decimal;
        BosaMgt: Codeunit "BOSA Management";
        Found: Boolean;
    begin
        Member.RESET;
        Member.SETRANGE("Phone No.", MobilePhoneNo);
        IF NOT Member.FIND('-') THEN BEGIN
            ResponseCode := '14';
            ErrorMessage := 'Member does not exist';
            EXIT;
        END ELSE BEGIN
            IF Member.Status <> Member.Status::Active THEN BEGIN
                ResponseCode := '14';
                ErrorMessage := 'Member not active';
                EXIT;
            END;
            LoanApplication.Reset();
            LoanApplication.SetRange("Member No.", Member."No.");
            LoanApplication.SetRange(Posted, true);
            if LoanApplication.FindSet() then begin
                Found := false;
                ResponseCode := '000';
                ResponseMessage := '{"member" :{';
                ResponseMessage +=
                                    '"name" :"' + Member."Full Name" +
                                    '","nationalId" : "' + Member."National ID" +
                                    //'","MemberImage" : "'+convert.ToBase64String(bytes)+
                                    '"}, "accounts" :[';
                hasaccounts := FALSE;
                REPEAT
                    InstallmentAmount := 0;
                    if LoanApplication."Disbursal Date" = 0D then begin
                        LoanApplication."Disbursal Date" := LoanApplication."Approved Date";
                        LoanApplication.Modify();
                        Commit();
                    end;
                    //Error('Loan %1..disb %2...comple %3..appr %4', LoanApplication."No.", LoanApplication."Disbursal Date", LoanApplication."Date of Completion", LoanApplication."Approved Date");
                    InstallmentAmount := GetNoofInstallments(LoanApplication."No.", LoanApplication."Disbursal Date", LoanApplication."Date of Completion");

                    IF LoanProductTypes.GET(LoanApplication."Loan Product Type") THEN BEGIN
                        IF (GetCustomerBalance(LoanApplication."No.") > 0) THEN BEGIN
                            ResponseMessage +=
                                            '{' +
                                                '"accountNo": "' + LoanApplication."No." +
                                                '","accountName": "' + LoanApplication.Description +
                                                '","canWithdraw" : "' + FORMAT(FALSE) +
                                                '","canDeposit": "' + FORMAT(TRUE) +
                                                '","isLoanAccount": "' + FORMAT(TRUE) +
                                                '","isNWD": "' + FORMAT(FALSE) +
                                                '","isShareCapital": "' + FORMAT(FALSE) +
                                                '","isSavingsAccount": "' + FORMAT(FALSE) +
                                                '","balance" : "' + FORMAT(GetCustomerBalance(LoanApplication."No.")) +
                                                '","maxWithdrawable" : "' + FORMAT(0) +
                                                //'","maxDeposit" : "'+FORMAT(accountTypes."Maximum Allowable Deposit")+
                                                '","createdDate" : "' + FORMAT(LoanApplication."Approved Date") +
                                                '","installmentAmount" : "' + FORMAT(InstallmentAmount) +
                                                '","tofinishdate" : "' + FORMAT(LoanApplication."Date of Completion") +
                                            '"},';
                            hasaccounts := TRUE;
                        END;
                    END;
                UNTIL LoanApplication.NEXT = 0;
                IF hasaccounts THEN BEGIN
                    ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
                END;
                ResponseMessage += ']}';
                EXIT;
            END;
        END;
    end;

    procedure GetMemberAccounts(VAR MobilePhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
    begin
        Member.RESET;
        Member.SETRANGE("Phone No.", MobilePhoneNo);
        IF NOT Member.FIND('-') THEN BEGIN
            ResponseCode := '14';
            ErrorMessage := 'Member does not exist';
            EXIT;
        END ELSE BEGIN
            IF Member.Status <> Member.Status::Active THEN BEGIN
                ResponseCode := '14';
                ErrorMessage := 'Member not active';
                EXIT;
            END;

            Vendor.RESET;
            Vendor.SETRANGE("Member No.", Member."No.");
            Vendor.SETFILTER(Status, '%1|%2|%3', Vendor.Status::Dormant, Vendor.Status::Active, Vendor.Status::Frozen);
            IF NOT Vendor.FIND('-') THEN BEGIN
                ResponseCode := '14';
                ErrorMessage := 'Member has no accounts attached';
                EXIT;
            END ELSE BEGIN
                ResponseCode := '000';
                ResponseMessage := '{"member" :{';
                ResponseMessage +=
                                '"name" :"' + Member."Full Name" +
                                '","nationalId" : "' + Member."National ID" +
                                //'","MemberImage" : "'+convert.ToBase64String(bytes)+
                                '"}, "accounts" :[';

                REPEAT
                    Vendor.CalcFields(Balance);
                    accountTypes.RESET;
                    accountTypes.SETRANGE(Code, Vendor."Account Type");
                    IF accountTypes.FINDFIRST THEN BEGIN
                        // IF (accountTypes.Type = accountTypes.Type::Loan) AND (Vendor.Balance>0) THEN BEGIN
                        //     ResponseMessage += 
                        //                     '{'+
                        //                         '"accountNo": "'+Vendor."No."+
                        //                         '","accountName": "'+Vendor.Name+
                        //                         '","canWithdraw" : "'+ FORMAT(accountTypes."Allow Withdrawal")+
                        //                         '","canDeposit": "'+FORMAT(accountTypes."Allow Deposit")+
                        //                         '","isLoanAccount": "'+FORMAT(TRUE)+
                        //                         '","isNWD": "'+FORMAT(FALSE)+
                        //                         '","isShareCapital": "'+FORMAT(FALSE)+
                        //                         '","isSavingsAccount": "'+FORMAT(FALSE)+
                        //                         '","balance" : "'+FORMAT(Vendor.Balance)+
                        //                         '","maxWithdrawable" : "'+FORMAT(accountTypes."Maximum No. of Withdrawal")+
                        //                         //'","maxDeposit" : "'+FORMAT(accountTypes.ma)+
                        //                     '"},';
                        // END;
                        IF (accountTypes.Type = accountTypes.Type::Savings) THEN BEGIN
                            ResponseMessage +=
                                            '{' +
                                                '"accountNo": "' + Vendor."No." +
                                                '","accountName": "' + Vendor.Name +
                                                '","canWithdraw" : "' + FORMAT(accountTypes."Allow Withdrawal") +
                                                '","canDeposit": "' + FORMAT(accountTypes."Allow Deposit") +
                                                '","isLoanAccount": "' + FORMAT(FALSE) +
                                                '","isNWD": "' + FORMAT(FALSE) +
                                                '","isShareCapital": "' + FORMAT(FALSE) +
                                                '","isSavingsAccount": "' + FORMAT(TRUE) +
                                                '","balance" : "' + FORMAT(Vendor.Balance) +
                                                '","maxWithdrawable" : "' + FORMAT(accountTypes."Maximum No. of Withdrawal") +
                                            '"},';
                        END;
                        IF (accountTypes.Type = accountTypes.Type::"Share Capital") THEN BEGIN
                            ResponseMessage +=
                                            '{' +
                                                '"accountNo": "' + Vendor."No." +
                                                '","accountName": "' + Vendor.Name +
                                                '","canWithdraw" : "' + FORMAT(accountTypes."Allow Withdrawal") +
                                                '","canDeposit": "' + FORMAT(accountTypes."Allow Deposit") +
                                                '","isLoanAccount": "' + FORMAT(FALSE) +
                                                '","isNWD": "' + FORMAT(FALSE) +
                                                '","isShareCapital": "' + FORMAT(TRUE) +
                                                '","isSavingsAccount": "' + FORMAT(FALSE) +
                                                '","balance" : "' + FORMAT(Vendor.Balance) +
                                                '","maxWithdrawable" : "' + FORMAT(accountTypes."Maximum No. of Withdrawal") +
                                            '"},';
                        END;
                        IF (accountTypes.Type = accountTypes.Type::"Member Deposit") THEN BEGIN
                            ResponseMessage +=
                                            '{' +
                                                '"accountNo": "' + Vendor."No." +
                                                '","accountName": "' + Vendor.Name +
                                                '","canWithdraw" : "' + FORMAT(accountTypes."Allow Withdrawal") +
                                                '","canDeposit": "' + FORMAT(accountTypes."Allow Deposit") +
                                                '","isLoanAccount": "' + FORMAT(FALSE) +
                                                '","isNWD": "' + FORMAT(TRUE) +
                                                '","isShareCapital": "' + FORMAT(FALSE) +
                                                '","isSavingsAccount": "' + FORMAT(FALSE) +
                                                '","balance" : "' + FORMAT(Vendor.Balance) +
                                                '","maxWithdrawable" : "' + FORMAT(accountTypes."Maximum No. of Withdrawal") +
                                            '"},';
                        END;

                    END;
                UNTIL Vendor.NEXT = 0;
                ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
                ResponseMessage += ']}';
                EXIT;
            end;
        end
    end;

    procedure TellerMgt(VAR request_id: Code[10]; VAR transaction_type: Integer; VAR amount: Decimal; VAR charges: Text[250]; VAR account_number: Code[50]; VAR cr_account: Code[50]; VAR status: Text; VAR f_key: Code[50]; VAR balance: Text; VAR message: Text[100]; VAR TellerTill: Code[10]; VAR "Response Message": Text[50]; VAR transacted_by: Code[40]; VAR auth_mode: Code[20]) response: Text[50];
    var
        LoanAccount: Boolean;
        BankAccount: Record "Bank Account";
        TransactionAmount: Decimal;
        Acctype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        PostDesc: Text;
        Member: Record Member;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Vendor: Record Vendor;
        JournalTemplateName: Code[20];
        JournalBatchName: Code[20];
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        AccountTypes: Record "Account Type";
        Customer: Record Customer;
        BranchCode: Code[10];
        AvailableBal: Decimal;
        Posted: Boolean;
        TrxnDescription: Text;
    begin
        BankAccount.GET(TellerTill);
        BankAccount.TESTFIELD("Global Dimension 1 Code");
        IF BankAccount.Blocked = TRUE THEN BEGIN
            status := '01';
            "Response Message" := 'Till is closed';
            EXIT;
        END;
        Clear(AvailableBal);

        VendorLedgerEntry.RESET;
        VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Document No.", request_id);
        IF VendorLedgerEntry.FIND('-') THEN BEGIN
            status := '01';
            "Response Message" := 'Duplicate Transaction';
            EXIT;
        END;
        //CBSSetup.GET;
        TelleringSetup.Get();
        JournalTemplateName := TelleringSetup."Teller Template Name";
        JournalBatchName := TelleringSetup."Teller Batch Name";

        Vendor.GET(account_number);
        Vendor.CALCFIELDS(Balance);
        if transaction_type = 1 then begin
            TrxnDescription := 'Withdrawal';
            IF Vendor.Status = Vendor.Status::Frozen THEN BEGIN
                status := '01';
                "Response Message" := 'Account is Frozen';
                EXIT;
            END;
            Member.Reset();
            Member.SetRange("No.", Vendor."Member No.");
            if Member.FindFirst() then begin
                BranchCode := Member."Global Dimension 1 Code";
                TellerUserSetup.Reset();
                TellerUserSetup.SetRange("Till No.", TellerTill);
                if TellerUserSetup.FindFirst() then begin
                    TransactionAmount := amount;
                    AvailableBal := CheckAvailableAmt(account_number, 0);
                    IF checkTotalCharges(706, TransactionAmount) > CheckAvailableAmt(account_number, 1) THEN BEGIN
                        response := '01';
                        "response message" := 'Insufficient Balance';
                        EXIT;
                    END;
                    IF TransactionAmount > AvailableBal THEN BEGIN
                        response := '01';
                        "response message" := 'Insufficient Balance: available: ' + format(AvailableBal) + ' trans amount:' + FORMAT(TransactionAmount);
                        EXIT;
                    END;
                    if TransactionAmount > (ChargeAmount + AvailableBal) then begin
                        response := '01';
                        "response message" := 'Insufficient Balance: available: ' + format(AvailableBal + ChargeAmount) + ' trans amount:' + FORMAT(TransactionAmount);
                        EXIT;
                    end;
                    //postWit
                    AccType := AccType::"Bank Account";
                    BalAccType := BalAccType::Vendor;
                    PostDesc := 'Withdrawal';
                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, TellerTill, '', PostDesc,
                                    -TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key);
                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, account_number, '', PostDesc,
                                    TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key);
                    //PostCharge
                    If ChargeAmount > 0 then begin
                        AccType := AccType::"G/L Account";
                        BalAccType := BalAccType::Vendor;
                        PostDesc := 'Withdrawal Charges';
                        if SaccoCharges > 0 then begin
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, SaccoGL, '', PostDesc,
                                            -SaccoCharges, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key);
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, account_number, '', PostDesc,
                                            SaccoCharges, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key);
                        end;
                        PostDesc := 'Excise Duty';
                        if ExciseAmount > 0 then begin
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, ExciseGL, '', PostDesc,
                                            -ExciseAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key);
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, account_number, '', PostDesc,
                                            ExciseAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key);
                        end;
                    end;
                    PostTransaction(JournalTemplateName, JournalBatchName);

                    AvailableBal := GetMemberBalance(account_number);
                    balance := FORMAT(AvailableBal);
                    status := '00';
                    "Response Message" := 'SUCCESS';

                end else begin
                    status := '02';
                    "Response Message" := 'Teller setup incomplete';
                    EXIT;
                end;
            end;
        end;
        if transaction_type = 5 then begin
            TrxnDescription := 'Deposit';
            PostDesc := 'Teller ' + TrxnDescription;
            LoanAccount := FALSE;
            LoanAccount := IsLoanAccount(account_number);
            AccType := AccType::"Bank Account";
            IF LoanAccount = TRUE THEN BEGIN
                BalAccType := BalAccType::Customer
            END ELSE
                BalAccType := BalAccType::Vendor;
            IF LoanAccount = TRUE THEN BEGIN
                PrepareLoanJournal(AccType, BankAccount."No.", BalAccType, account_number, TransactionAmount, request_id, PostDesc, JournalTemplateName, JournalBatchName);
            END ELSE BEGIN
                AccType := AccType::"Bank Account";
                BalAccType := BalAccType::Vendor;
                CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, TellerTill, '', PostDesc,
                                TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key);
                CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, account_number, '', PostDesc,
                                -TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key);
            END;
            Member.Reset();
            Member.SetRange("No.", Vendor."Member No.");
            if Member.FindFirst() then begin
                BranchCode := Member."Global Dimension 1 Code";
                TellerUserSetup.Reset();
                TellerUserSetup.SetRange("Till No.", TellerTill);
                if TellerUserSetup.FindFirst() then begin
                    TransactionAmount := amount;
                    AvailableBal := CheckAvailableAmt(account_number, 0);
                    IF checkTotalCharges(706, TransactionAmount) > CheckAvailableAmt(account_number, 1) THEN BEGIN
                        response := '01';
                        "response message" := 'Insufficient Balance';
                        EXIT;
                    END;
                    IF TransactionAmount > AvailableBal THEN BEGIN
                        response := '01';
                        "response message" := 'Insufficient Balance: available: ' + format(AvailableBal) + ' trans amount:' + FORMAT(TransactionAmount);
                        EXIT;
                    END;
                    if TransactionAmount > (ChargeAmount + AvailableBal) then begin
                        response := '01';
                        "response message" := 'Insufficient Balance: available: ' + format(AvailableBal + ChargeAmount) + ' trans amount:' + FORMAT(TransactionAmount);
                        EXIT;
                    end;
                    //postWit
                    AccType := AccType::"Bank Account";
                    BalAccType := BalAccType::Vendor;
                    PostDesc := 'Withdrawal';
                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, TellerTill, '', PostDesc,
                                    -TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key);
                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, account_number, '', PostDesc,
                                    TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key);
                    //PostCharge
                    If ChargeAmount > 0 then begin
                        AccType := AccType::"G/L Account";
                        BalAccType := BalAccType::Vendor;
                        PostDesc := 'Withdrawal Charges';
                        if SaccoCharges > 0 then begin
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, SaccoGL, '', PostDesc,
                                            -SaccoCharges, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key);
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, account_number, '', PostDesc,
                                            SaccoCharges, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key);
                        end;
                        PostDesc := 'Excise Duty';
                        if ExciseAmount > 0 then begin
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, ExciseGL, '', PostDesc,
                                            -ExciseAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key);
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, account_number, '', PostDesc,
                                            ExciseAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key);
                        end;
                    end;
                    PostTransaction(JournalTemplateName, JournalBatchName);

                    AvailableBal := GetMemberBalance(account_number);
                    balance := FORMAT(AvailableBal);
                    status := '00';
                    "Response Message" := 'SUCCESS';

                end else begin
                    status := '02';
                    "Response Message" := 'Teller setup incomplete';
                    EXIT;
                end;
            end;
        end;

        CreateTransactionsEntries(request_id, TrxnDescription, transaction_type, amount, Posted, account_number, TellerTill);
        //end teller
    end;

    Local procedure isLoanAccount(VAR AccountNo: Code[20]) isLoan: boolean
    var
        CustomerRec: Record Customer;

    begin
        CustomerRec.RESET;
        CustomerRec.SETRANGE("No.", AccountNo);
        CustomerRec.SETRANGE(Status, CustomerRec.Status::Active);
        IF CustomerRec.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    local procedure SendLoanNotification(AccountNo: Code[20]; TransAmount: Decimal)
    var
        MobileSetup: Record "Mobile Banking Setup";
        GlobalM: Codeunit "Global Management";
        SMSText: BigText;
        LoanApp: Record "Loan Application";
        Member: Record Member;
        SourceCodeSetup: Record "Source Code Setup";
        MemberName: array[5] of Text;
    begin
        SourceCodeSetup.Get();
        MobileSetup.Get();
        MemberName[2] := '';
        LoanApp.Get(AccountNo);
        LoanApp.CalcFields("Outstanding Balance");
        SourceCodeSetup.TestField(Loan);
        Member.GET(LoanApp."Member No.");
        MemberName[2] := COPYSTR(Member."Full Name", 1, STRPOS(Member."Full Name", ' '));
        CLEAR(SMSText);

        SMSText.ADDTEXT(STRSUBSTNO(MobileSetup."Loan Repay SMS Template", MemberName[2], TransAmount, LoanApp.Description, LoanApp."Outstanding Balance"));
        GlobalM.CreateSMSEntry(Member."Phone No.", SMSText, SourceCodeSetup.Loan);
    end;

    local procedure PrepareJournal(AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccNo: Code[20]; BalType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; BalAccNo: Code[20]; TransAmount: Decimal; RequestID2: Code[20]; DescriptionTxt: Text; PhoneNo: Text)
    var
        JournalTemplateName: Code[20];
        JournalBatchName: Code[20];
        Customer: Record Customer;
    begin
        JournalTemplateName := JournalTemplateName;
        JournalBatchName := JournalBatchName;

        CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID2, AccType, AccNo, '', DescriptionTxt,
                        TransAmount, Customer."Global Dimension 1 Code", BalType::"G/L Account", '', Customer."Member No.", Today, 1, RequestID2);
        CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID2, BalType, BalAccNo, '', DescriptionTxt,
                        -TransAmount, Customer."Global Dimension 1 Code", BalType::"G/L Account", '', Customer."Member No.", Today, 2, RequestID2);

    end;

    local procedure CreateJnlLine(JournalTemplateName: Code[20]; JournalBatchName: Code[20]; RequestID: Code[20]; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[30]; TransactionTypes: Code[10]; Description: Text[50]; PostingAmount: Decimal; GlobalDimensionCode: Code[20]; BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; BalAccountNo: Code[30]; MemberNo: Code[20]; PostingDate: Date; LineNo: Integer; F_key: code[40])
    var
        TempGenJournalLine: Record "Gen. Journal Line";

    begin
        TempGenJournalLine.INIT;
        TempGenJournalLine."Journal Template Name" := JournalTemplateName;
        TempGenJournalLine."Journal Batch Name" := JournalBatchName;
        TempGenJournalLine."Document No." := RequestID;
        TempGenJournalLine."External Document No." := F_key;
        TempGenJournalLine."Line No." := LineNo;
        TempGenJournalLine."Account Type" := AccountType;
        TempGenJournalLine.VALIDATE(TempGenJournalLine."Account No.", AccountNo);
        TempGenJournalLine."Posting Date" := PostingDate;
        TempGenJournalLine."Shortcut Dimension 1 Code" := GlobalDimensionCode;
        TempGenJournalLine.VALIDATE(TempGenJournalLine."Shortcut Dimension 1 Code");
        TempGenJournalLine.Description := Description;
        TempGenJournalLine.VALIDATE(TempGenJournalLine."Currency Code", '');
        TempGenJournalLine."Transaction Type Code" := TransactionTypes;
        TempGenJournalLine.VALIDATE(TempGenJournalLine.Amount, PostingAmount);
        //TempGenJournalLine.VALIDATE("Shortcut Dimension 1 Code",Globaldim);
        IF TempGenJournalLine.Amount <> 0 THEN BEGIN
            TempGenJournalLine.INSERT;
        END;
        LineNo += 1;

    end;

    local procedure PostTransaction(JournalTemplateName: Code[20]; JournalBatchName: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";

    begin
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", JournalTemplateName);
        GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", JournalBatchName);
        IF GenJournalLine.FINDSET THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine);
        END;
    end;

    procedure ProcessReversal(VAR RequestID: Code[20]; VAR ResponseCode: Code[20]; VAR ResponseMessage: Text; VAR ErrorMessage: Text)
    var
        GLEntry: Record "G/L Entry";
        ReversalEntry: Record "Reversal Entry";

    begin
        GLEntry.RESET;
        GLEntry.SETRANGE("Document No.", RequestID);
        GLEntry.SETRANGE(Reversed, FALSE);
        IF NOT GLEntry.FINDSET THEN BEGIN
            ResponseCode := '59';
            ErrorMessage := 'Document No: ' + RequestID + ' not Found!';
            EXIT;
        END;
        GLEntry.RESET;
        GLEntry.SETRANGE("Document No.", RequestID);
        GLEntry.SETRANGE(Reversed, FALSE);
        IF GLEntry.FINDSET THEN BEGIN
            REPEAT
                ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");
            UNTIL GLEntry.NEXT = 0;
        END;

        ResponseCode := '00';
        ResponseMessage := 'Successfully Reversed ' + RequestID;
        EXIT;
    end;

    local procedure CreateTransactionsEntries(TransctionNo: Code[20]; Description: Text; TransactionType: Integer; AmountT: Decimal; Posted: Boolean; Account_number: Code[50]; TellerTill: Code[20])
    var
        TransactionsTable: Record "Teller Transaction Header";
        UserSetup: Record "User Setup";
        TransactionTypeRec: Record "Transaction -Type";
    begin
        TransactionsTable.INIT;
        TransactionsTable."No." := TransctionNo;
        TransactionTypeRec.Reset();
        if TransactionType = 1 then
            TransactionTypeRec.SetRange(Type, TransactionTypeRec.Type::"Teller Cash Withdrawal");
        if TransactionTypeRec.FindFirst() then begin
            TransactionsTable."Transaction Type" := TransactionTypeRec.Code;
        end;

        TransactionsTable.Description := Description;
        TransactionsTable."Transaction Amount" := AmountT;
        TransactionsTable."Account No." := Account_number;
        TransactionsTable."Transaction Date" := TODAY;
        TransactionsTable."Transaction Time" := TIME;
        TellerUserSetup.Reset();
        TellerUserSetup.SetFilter("Till No.", TellerTill);
        if TellerUserSetup.FindFirst() then begin
            TransactionsTable."Teller User ID" := TellerUserSetup."User ID";
            BankAccount.Reset();
            BankAccount.SetRange("No.", TellerTill);
            if BankAccount.FindFirst() then begin
                BankAccount.CalcFields(Balance);
                TransactionsTable."Till Balance" := BankAccount.Balance;
            end;
        end;
        TransactionsTable.Posted := Posted;
        TransactionsTable."Posted By" := UserId;
        TransactionsTable."Posted Date" := Today;
        TransactionsTable."Posted Time" := Time;
        TransactionsTable.INSERT;
    end;

    local procedure checkTotalCharges(Transaction_Type: Integer; Amount: Decimal) TotalCharges: Decimal
    var
        TransactionTypes: Record "Transaction -Type";
        Charge: Record Charge;
    begin
        TotalCharges := 0;
        TransactionTypes.RESET;
        IF Transaction_Type = 700 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Mobile Banking Balance Inquiry");
        END;
        ;
        IF Transaction_Type = 701 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Mobile Banking Balance Inquiry");
        END;
        IF Transaction_Type = 702 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Mobile Banking Balance Inquiry");
        END;
        IF Transaction_Type = 703 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Mobile Banking Balance Inquiry");
        END;
        IF Transaction_Type = 704 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Mobile Banking Ministatement");
        END;
        IF Transaction_Type = 705 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Mobile Banking Deposit");
        END;
        IF Transaction_Type = 706 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Mobile Banking Withdrawal");
        END;
        IF Transaction_Type = 707 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Agency Airtime");
        END;
        IF Transaction_Type = 708 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Inter-Account");
        END;
        IF TransactionTypes.FINDSET THEN BEGIN
            Charge.RESET;
            Charge.SETRANGE(Type, TransactionTypes.Type);
            Charge.SETFILTER("Minimum Amount", '<=%1', Amount);
            Charge.SETFILTER("Maximum Amount", '>=%1', Amount);
            IF Charge.FINDSET THEN BEGIN
                SaccoCharges := Charge."Charge Amount";
                SaccoGL := Charge."GL Account";
                ExciseAmount := (Charge."Excise %" * Charge."Charge Amount") / 100;
                ExciseGL := Charge."Excise G/L Account";
                SettlementAmount := Charge."Settlement Amount";
                BankAccount.RESET;
                BankAccount.SETRANGE("Paybill Bank", TRUE);
                IF BankAccount.FINDFIRST THEN BEGIN
                    SettlementGL := BankAccount."No.";
                END;
                ChargeAmount := SaccoCharges + ExciseAmount + SettlementAmount;
                TotalCharges := ChargeAmount;
            END;
        END;
    end;

    LOCAL procedure CheckAvailableAmount(Transaction_type: Integer; PhoneNo: Code[20]; CheckAccountType: Integer; CheckAccountNo: Code[20]) AvailableAmount: Decimal
    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";

    begin
        AvailableAmount := 0;
        Member.RESET;
        Member.SETRANGE("Phone No.", PhoneNo);
        IF Member.FINDSET THEN BEGIN
            IF CheckAccountNo <> '' THEN BEGIN
                IF Vendor.GET(CheckAccountNo) THEN BEGIN
                    Vendor.CALCFIELDS(Balance);
                    AvailableAmount := Vendor.Balance;
                    AccountTypes.RESET;
                    AccountTypes.SETRANGE(Code, Vendor."Account Type");
                    IF AccountTypes.FINDFIRST THEN BEGIN
                        AvailableAmount := AvailableAmount - AccountTypes."Minimum Balance";
                        //IF AvailableAmount>0 THEN BEGIN
                        EXIT(AvailableAmount);
                    END;
                END;
            END;
            AccountTypes.RESET;
            IF CheckAccountType = 1 THEN
                AccountTypes.SETRANGE(Type, AccountTypes.Type::Savings);
            IF AccountTypes.FINDSET THEN BEGIN
                REPEAT
                    Vendor.RESET;
                    Vendor.SETRANGE("Member No.", Member."No.");
                    Vendor.SETRANGE("Account Type", AccountTypes.Code);
                    IF Vendor.FINDSET THEN BEGIN
                        Vendor.CALCFIELDS(Balance);
                        AvailableAmount := Vendor.Balance;
                        AvailableAmount := AvailableAmount - AccountTypes."Minimum Balance";
                        IF AvailableAmount > 0 THEN BEGIN
                            EXIT(AvailableAmount);
                        END;
                    END;
                UNTIL AccountTypes.NEXT = 0;
            END;
        END;
    end;

    LOCAL procedure CheckAvailableAmt(AccountNo: Code[20]; CheckAccountType: Integer) AvailableAmount: Decimal
    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";

    begin
        if CheckAccountType = 0 then begin
            Vendor.RESET;
            Vendor.SETRANGE("No.", AccountNo);
            Vendor.SETRANGE("Account Type", AccountTypes.Code);
            IF Vendor.FINDSET THEN BEGIN
                Vendor.CALCFIELDS(Balance);
                AvailableAmount := Vendor.Balance;
                AccountTypes.Reset();
                ;
                AccountTypes.SetRange(Code, Vendor."Account Type");
                if AccountTypes.FindFirst() then begin
                    if AccountTypes."Minimum Balance" > 0 then
                        AvailableAmount -= AccountTypes."Minimum Balance";
                end;
                EXIT(AvailableAmount);
            END;
        end;

        AvailableAmount := 0;
        AccountTypes.RESET;
        IF CheckAccountType = 1 THEN
            AccountTypes.SETRANGE(Type, AccountTypes.Type::Savings);
        IF AccountTypes.FINDSET THEN BEGIN
            REPEAT
                Vendor.RESET;
                Vendor.SETRANGE("No.", AccountNo);
                Vendor.SETRANGE("Account Type", AccountTypes.Code);
                IF Vendor.FINDSET THEN BEGIN
                    Vendor.CALCFIELDS(Balance);
                    AvailableAmount := Vendor.Balance;
                    AvailableAmount := AvailableAmount - AccountTypes."Minimum Balance";
                    IF AvailableAmount > 0 THEN BEGIN
                        EXIT(AvailableAmount);
                    END;
                END;
            UNTIL AccountTypes.NEXT = 0;
        END;
    end;

    LOCAL procedure GetMemberBalance(AccountNo: Code[20]) MemberAccountBalance: Decimal
    var
        Vendor: Record Vendor;

    begin
        IF Vendor.GET(AccountNo) THEN BEGIN
            Vendor.CALCFIELDS(Balance);
            MemberAccountBalance := ABS(Vendor.Balance);
            EXIT(MemberAccountBalance);
        END;
    end;

    LOCAL procedure GetCustomerBalance(AccountNo: Code[20]) MemberAccountBalance: Decimal
    var
        CustomerRec: Record Customer;
    begin
        IF CustomerRec.GET(AccountNo) THEN BEGIN
            CustomerRec.CALCFIELDS(Balance);
            MemberAccountBalance := ABS(CustomerRec.Balance);
            EXIT(MemberAccountBalance);
        END;
    end;

    procedure GetRepaymentFrequencyDateFormula(LoanApplication: Record "Loan Application") DateFormula: Code[20]
    var
        LoanProductType: Record "Loan Product Type";
    begin
        with LoanApplication DO begin
            IF LoanProductType.GET("Loan Product Type") THEN BEGIN
                IF LoanProductType."Repayment Frequency" = LoanProductType."Repayment Frequency"::Annually THEN
                    DateFormula := '1Y';
                IF LoanProductType."Repayment Frequency" = LoanProductType."Repayment Frequency"::Quarterly THEN
                    DateFormula := '3M';
                IF LoanProductType."Repayment Frequency" = LoanProductType."Repayment Frequency"::Monthly THEN
                    DateFormula := '1M';
                IF LoanProductType."Repayment Frequency" = LoanProductType."Repayment Frequency"::Fortnightly THEN
                    DateFormula := '2W';
                IF LoanProductType."Repayment Frequency" = LoanProductType."Repayment Frequency"::Weekly THEN
                    DateFormula := '1W';
                IF LoanProductType."Repayment Frequency" = LoanProductType."Repayment Frequency"::Daily THEN
                    DateFormula := '1D';
            END;
            EXIT(DateFormula);
        END;
    end;

    local procedure GetNoofInstallments(LoanNo: Code[20]; StartDate: Date; EndDate: Date): Integer
    var
        LoanApplication: Record "Loan Application";
        j: Integer;
        LastRepaymentDate: Date;
        NextRepaymentDate: Date;
        DateFormula: DateFormula;
    begin
        j := 0;
        LoanApplication.GET(LoanNo);
        EVALUATE(DateFormula, GetRepaymentFrequencyDateFormula(LoanApplication));
        LastRepaymentDate := EndDate;
        NextRepaymentDate := StartDate;
        WHILE NextRepaymentDate <= LastRepaymentDate DO BEGIN
            NextRepaymentDate := CALCDATE(DateFormula, NextRepaymentDate);
            j += 1;
        END;
        EXIT(j - 1);
    end;

    local procedure GetLast5Transactions(AccountNo: Code[20]; VAR TotalMiniTransactions: BigText)
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        i: Integer;
        TransactionType: Code[10];
        MiniTransactions: Text[1024];
    begin
        i := 0;
        MiniTransactions := '';
        VendorLedgerEntry.RESET;
        VendorLedgerEntry.SETRANGE("Vendor No.", AccountNo);
        VendorLedgerEntry.SETFILTER(Description, '<>%1', '@*charges*');
        VendorLedgerEntry.SETASCENDING("Entry No.", FALSE);
        VendorLedgerEntry.SETRANGE(Reversed, FALSE);
        IF VendorLedgerEntry.FINDSET() THEN BEGIN
            REPEAT
                i += 1;
                VendorLedgerEntry.CALCFIELDS(Amount);
                IF VendorLedgerEntry.Amount < 0 THEN
                    TransactionType := 'CR'
                ELSE
                    IF VendorLedgerEntry.Amount > 0 THEN
                        TransactionType := 'DR';
                MiniTransactions := FORMAT(VendorLedgerEntry."Posting Date") + ' ' + COPYSTR(VendorLedgerEntry.Description, 1, 12) + ' KES:' + FORMAT(-1 * VendorLedgerEntry.Amount) + ' |' + MiniTransactions;
            UNTIL ((VendorLedgerEntry.NEXT = 0) OR (i = 10));

        END;
        TotalMiniTransactions.ADDTEXT((MiniTransactions));
    end;

    LOCAL procedure GetLast5LoanTransactions(AccountNo: Code[20]; VAR TotalMiniTransactions: BigText)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        i: Integer;
        TransactionType: Code[10];
        MiniTransactions: Text;
    begin
        MiniTransactions := '';
        i := 0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Customer No.", AccountNo);
        CustLedgerEntry.SETASCENDING("Entry No.", FALSE);
        CustLedgerEntry.SETRANGE(Reversed, FALSE);
        if CustLedgerEntry.FindSet() then begin
            REPEAT
                i += 1;
                CustLedgerEntry.CALCFIELDS(Amount);
                IF CustLedgerEntry.Amount < 0 THEN
                    TransactionType := 'CR'
                ELSE
                    IF CustLedgerEntry.Amount > 0 THEN
                        TransactionType := 'DR';
                MiniTransactions := FORMAT(CustLedgerEntry."Posting Date") + ' ' + COPYSTR(CustLedgerEntry.Description, 1, 12) + ' KES:' + FORMAT(-1 * CustLedgerEntry.Amount) + ' |' + MiniTransactions;
            UNTIL ((CustLedgerEntry.NEXT = 0) OR (i = 10));
        END;
        TotalMiniTransactions.ADDTEXT((MiniTransactions));
    end;

    procedure FetchNewRegistrations(VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text)
    var
        Member: Record Member;
        MobileApp: Record "Mobile Banking Application";
        JsonSMSText1: Text;
        JsonSMSText2: Text;
        MobileBankingMember: Record "Mobile Banking Member";
    begin
        MobileBankingMember.Reset();
        MobileBankingMember.SetRange("Updated On Portal", false);
        MobileBankingMember.SetRange(Status, MobileBankingMember.Status::Active);
        if MobileBankingMember.FindSet() then begin
            JsonSMSText1 := '{"NewRegistrations": [';
            repeat
                Member.RESET;
                Member.SETRANGE("No.", MobileBankingMember."Member No.");
                IF Member.FindFirst() THEN BEGIN
                    JsonSMSText1 += '{';
                    JsonSMSText1 += '"customer_name":';
                    JsonSMSText1 += '"' + FORMAT(Member."Full Name") + '",';
                    JsonSMSText1 += '"msisdn":';
                    JsonSMSText1 += '"' + FORMAT(Member."Phone No.") + '",';
                    JsonSMSText1 += '"idno":';
                    JsonSMSText1 += '"' + FORMAT(Member."National ID") + '"},';
                END;
            Until MobileBankingMember.Next = 0;
            JsonSMSText2 := COPYSTR(JsonSMSText1, 1, STRLEN(JsonSMSText1) - 1);
            JsonSMSText2 += ']}';
            ResponseCode := '00';
            ResponseMessage := JsonSMSText2;
            EXIT;
        END ELSE BEGIN
            ResponseCode := '14';
            ResponseMessage := 'No SMS found';
            ErrorMessage := 'No SMS found';
            EXIT;
        END;
    end;

    procedure UpdateRegisteredMembers(VAR PhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text)
    var
        Member: Record Member;
        PhoneNo_: Code[20];
        MobileApp: Record "Mobile Banking Application";
        MobileBankingMember: Record "Mobile Banking Member";
    begin
        EVALUATE(PhoneNo_, PhoneNo);
        MobileBankingMember.RESET;
        MobileBankingMember.SETRANGE("Phone No.", PhoneNo_);
        IF MobileBankingMember.FINDFIRST THEN BEGIN
            MobileBankingMember."Updated on Portal" := TRUE;
            MobileBankingMember.MODIFY(TRUE);
            if Member.Get(MobileBankingMember."Member No.") then begin
                Member."Updated On Portal" := true;
                Member.Modify();
            end;
            ResponseCode := '00';
            ResponseMessage := 'Success';
            EXIT;
        END ELSE BEGIN
            ResponseCode := '14';
            ResponseMessage := 'Member Not Found';
            ErrorMessage := 'Member Not Found';
            EXIT;
        END;
    end;

    local procedure PrepareLoanJournal(AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccNo: Code[20]; BalType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; BalAccNo: Code[20]; TransAmount: Decimal; RequestID2: Code[20]; DescriptionTxt: text; JournalTemplate: text; JournalBatch: text)

    var
        InterestDue: decimal;
        PrincipalDue: Decimal;
        InsuranceDue: Decimal;
        JournalTemplateName: Code[20];
        JournalBatchName: Code[20];
        Customer: Record Customer;
        AmountBalance: Decimal;
        ToSavings: Decimal;
        RequestID: code[20];
        AccountNo: Code[20];
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        TransactionType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        Description: Text;
        Amount: Decimal;
        GlobalDimensionCode: code[20];
        BalAccountNo: Code[20];
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        MemberNo: code[20];
        postingDate: Date;
        Member: Record Member;
        SavingsAcc: Code[20];
        LoanApp: Record "Loan Application";
        TType: Option " ",Deposit,Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Shares Contribution","Welfare Contribution","Registration Fee","Administration Fee",Dividend,"Withholding Tax","Loan Adjustment";
    begin
        //CBSSetup.GET;
        JournalTemplateName := JournalTemplateName;
        JournalBatchName := JournalBatch;
        GetLoanBalances(BalAccNo, PrincipalDue, InterestDue, InsuranceDue);
        ToSavings := 0;
        AmountBalance := TransAmount;
        //ERROR('Interest %1,prin %2,Sav %3, savin acc %4',InterestDue,PrincipalDue,ToSavings,SavingsAcc);
        IF InterestDue > 0 THEN BEGIN
            IF InterestDue >= TransAmount THEN BEGIN
                InterestDue := TransAmount;
                InsuranceDue := 0;
                PrincipalDue := 0;
                AmountBalance := 0;
            END ELSE BEGIN
                AmountBalance -= InterestDue;
            END;
        END ELSE BEGIN
            InterestDue := 0;
        END;
        IF InsuranceDue > 0 THEN BEGIN
            IF InsuranceDue >= AmountBalance THEN BEGIN
                InsuranceDue := AmountBalance;
                PrincipalDue := 0;
                AmountBalance := 0;
            END ELSE BEGIN
                AmountBalance -= InsuranceDue;
            END;
        END ELSE BEGIN
            InsuranceDue := 0;
        END;

        IF PrincipalDue > 0 THEN BEGIN
            IF PrincipalDue >= AmountBalance THEN BEGIN
                PrincipalDue := AmountBalance;
                AmountBalance := 0;
            END ELSE BEGIN
                AmountBalance -= PrincipalDue;
            END;
        END ELSE BEGIN
            PrincipalDue := 0;
        END;

        if LoanApp.Get(AccNo) then begin
            if Member.Get(LoanApp."Member No.") then begin
                MemberNo := Member."No.";
                GlobalDimensionCode := Member."Global Dimension 1 Code";
                RequestID := RequestID2;
                AccountType := AccType;
                AccountNo := AccNo;
                BalAccountType := BalAccountType::"G/L Account";
                BalAccountNo := '';
                PostingDate := TODAY;
                Amount := TransAmount;
                if AmountBalance > 0 then begin
                    SavingsAcc := GetSavingsAccount(MemberNo);
                    ToSavings := AmountBalance;
                end;
                if InterestDue > 0 then begin
                    CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, 'INTPAID', 'Interest Payment Deposit',
                                    InterestDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 1, '');
                    CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, 'INTPAID', 'Interest Payment Deposit',
                                    -InterestDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 2, '');
                end;
                if InsuranceDue > 0 then begin
                    CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, 'INSPAID', 'Insurance Payment Deposit',
                                    InsuranceDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 1, '');
                    CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, 'INSPAID', 'Insurance Payment Deposit',
                                    -InsuranceDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 2, '');
                end;
                if PrincipalDue > 0 then begin
                    CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, 'PPAID', 'Principal Payment Deposit',
                                    PrincipalDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 1, '');
                    CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, 'PPAID', 'Principal Payment Deposit',
                                    -PrincipalDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 2, '');
                end;
                IF (ToSavings > 0) AND (SavingsAcc <> '') THEN begin
                    CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, '', STRSUBSTNO('Loan %1 OverRecovery', BalAccNo),
                                    ToSavings, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 1, '');
                    CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Vendor, SavingsAcc, '', STRSUBSTNO('Loan %1 OverRecovery', BalAccNo),
                                    -ToSavings, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 2, '');
                end;
            end;
        end;
    end;

    local procedure GetLoanBalances(LoanNo: Code[20]; VAR PrincipalDue: Decimal; VAR InterestDue: Decimal; VAR InsuranceDue: Decimal)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedger: Record "Detailed Cust. Ledg. Entry";
    begin
        /* CustLedgerEntry.RESET;
         CustLedgerEntry.SETRANGE("Customer No.", LoanNo);
         IF CustLedgerEntry.FINDSET THEN BEGIN
             REPEAT
                 CustLedgerEntry.CALCFIELDS(Amount);
                 IF CustLedgerEntry."Transaction Type Code" IN ['NEWLOAN', 'PPAID', ''] THEN BEGIN
                     PrincipalDue += CustLedgerEntry.Amount;
                 END ELSE IF CustLedgerEntry."Transaction Type Code" IN ['INTPAID', 'INTDUE'] THEN BEGIN
                     InterestDue += CustLedgerEntry.Amount;
                 END;
             UNTIL CustLedgerEntry.NEXT = 0;
         END;
 */
        DetailedCustLedger.RESET;
        DetailedCustLedger.SETRANGE("Customer No.", LoanNo);
        IF DetailedCustLedger.FINDSET THEN BEGIN
            REPEAT
                IF DetailedCustLedger."Transaction Type Code" IN ['NEWLOAN', 'PPAID', ''] THEN BEGIN
                    PrincipalDue += DetailedCustLedger.Amount;
                END ELSE
                    IF DetailedCustLedger."Transaction Type Code" IN ['INTPAID', 'INTDUE'] THEN BEGIN
                        InterestDue += DetailedCustLedger.Amount;
                    END ELSE
                        IF DetailedCustLedger."Transaction Type Code" IN ['INSPAID', 'INSDUE'] THEN BEGIN
                            InsuranceDue += DetailedCustLedger.Amount;
                        END;
            UNTIL DetailedCustLedger.NEXT = 0;
        END;
    end;

    local procedure GetSavingsAccount(VAR MemberNo: Code[20]) SavingsAccount: Code[20]
    var
        AccountTypes: Record "Account Type";
        Vendor: Record Vendor;
    begin
        AccountTypes.RESET;
        AccountTypes.SETRANGE(Type, AccountTypes.Type::Savings);
        IF AccountTypes.FINDSET then begin
            REPEAT
                Vendor.RESET;
                Vendor.SETRANGE("Account Type", AccountTypes.Code);
                Vendor.SETRANGE("Member No.", MemberNo);
                IF Vendor.FINDSET THEN BEGIN
                    Vendor.Blocked := Vendor.Blocked::" ";
                    Vendor.MODIFY;
                    SavingsAccount := Vendor."No.";
                    EXIT(SavingsAccount);
                END;
            UNTIL AccountTypes.NEXT = 0;
        END;
    end;

    var
        i: Integer;
        NoSeriesMgt: Codeunit "No. Series";// TelleringSetup: Record "Tellering Setup";
        GenJournalLine: Record "Gen. Journal Line";
        TellerUserSetup: Record "Teller User Setup";
        ApprovalsMgmt: Codeunit "Approvals Mgmt Ext";
        JournalTemplateName: Code[20];
        JournalBatchName: Code[20];
        PrintTransactionReceiptConfirmMsg: Label 'Do you want to print Transaction receipt?';
        GlobalManagement: Codeunit "Global Management";
        LoanProductType: Record "Loan Product Type";
        OriginalPostingGroup: Code[20];
        LoanApplication: Record "Loan Application";
        SourceCodeSetup: Record "Source Code Setup";
        Customer: Record Customer;
        SMSEntry: Record "SMS Entry";
        DepositSMSTextMsg: Label 'Dear Member, We have received KES %1. Kinangop Boost Sacco';
        WithdrawalSMSTextMsg: Label 'Dear Member, You have withdrawn KES %1. Kinangop Boost Sacco';
        Member: Record Member;
        TransactionType: Record "Transaction -Type";
        InsufficientAccBalErrMsg: Label 'Insufficient Account Balance';
        UserSetup: Record "User Setup";
        TelleringSetup: Record "Tellering Setup";
        AccountTypeEnum: Enum "Gen. Journal Account Type";
        BalAccountTypeEnum: Enum "Gen. Journal Account Type";
        AppliesToDocTypeEnum: Enum "Gen. Journal Document Type";
        TransactionTpeCodeSetup: Record "Transaction Type Code Setup";
        SaccoCharges: Decimal;
        SaccoGL: code[10];
        ExciseAmount: Decimal;
        ExciseGL: code[10];
        SettlementAmount: Decimal;
        SettlementGL: code[10];
        ChargeAmount: Decimal;
        BankAccount: Record "Bank Account";

}