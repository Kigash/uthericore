codeunit 50080 "Agency Banking"
{
    trigger OnRun()
    begin

    end;

    procedure GetMemberDetails(VAR MemberNo: Text; VAR NationalIDNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    var
        Member: Record Member;
        Member2: Record Member;

    begin
        If NationalIDNo <> '' then begin
            Member.RESET;
            Member.SETRANGE("National ID", NationalIDNo);
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
                ResponseCode := '00';
                ResponseMessage := '{"member" :{';
                ResponseMessage += '"name" :"' + Member."Full Name" +
                                    '","nationalId" : "' + Member."National ID" +
                                    '","phoneNo" : "' + Member."Phone No." + '"}}';
                EXIT;
            END;
        end else begin
            If MemberNo <> '' then begin
                Member.RESET;
                Member.SETRANGE("No.", MemberNo);
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
                    ResponseCode := '00';
                    ResponseMessage := '{"member" :{';
                    ResponseMessage += '"name" :"' + Member."Full Name" +
                                        '","nationalId" : "' + Member."National ID" +
                                        '","phoneNo" : "' + Member."Phone No." + '"}}';
                    EXIT;
                END;
            end;
        end;
    end;

    local Procedure GetSavingsAccounts(VAR MobilePhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
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

    Procedure GetFieldAccounts(VAR IdNumber: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    var
        Member: Record Member;
        Member2: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
        Found: Boolean;
    begin
        Member.RESET;
        Member.SETRANGE("National ID", IdNumber);
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
        Member2.Reset();
        Member2.SetRange("National ID", IdNumber);
        If Member2.FindSet() then begin
            If Member2.Count = 1 then begin
                Vendor.RESET;
                Vendor.SETRANGE("Member No.", Member2."No.");
                Vendor.SetRange("Account Type", '04');
                IF NOT Vendor.FIND('-') THEN BEGIN
                    ResponseCode := '14';
                    ErrorMessage := 'Member has no accounts attached';
                    EXIT;
                END ELSE BEGIN
                    ResponseCode := '000';
                    ResponseMessage := '{"member" :{';
                    ResponseMessage +=
                                    '"name" :"' + Member2."Full Name" +
                                    '","nationalId" : "' + Member2."National ID" +
                                    '"}, "accounts" :[';

                    REPEAT
                        Vendor.CalcFields(Balance);
                        accountTypes.RESET;
                        accountTypes.SETRANGE(Code, Vendor."Account Type");
                        accountTypes.SETRANGE(Type, accountTypes.Type::Savings);
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
            end else begin
                If Member2.Count > 1 then begin
                    repeat
                        Vendor.RESET;
                        Vendor.SETRANGE("Member No.", Member2."No.");
                        Vendor.SetRange("Account Type", '04');
                        IF Vendor.FIND('-') THEN BEGIN
                            ResponseCode := '000';
                            ResponseMessage := '{"member" :{';
                            ResponseMessage +=
                                            '"name" :"' + Member2."Full Name" +
                                            '","nationalId" : "' + Member2."National ID" +
                                            '"}, "accounts" :[';

                            REPEAT
                                Vendor.CalcFields(Balance);
                                accountTypes.RESET;
                                accountTypes.SETRANGE(Code, Vendor."Account Type");
                                accountTypes.SETRANGE(Type, accountTypes.Type::Savings);
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
                        END;
                    until Member2.Next = 0;
                end;
            end;
        end;

    end;

    local Procedure GetNWDAccounts(VAR MobilePhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
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

    local Procedure GetShareCapitalAccounts(VAR MobilePhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
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

    procedure GetMemberAccounts(VAR Idnumber: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    var
        Member: Record Member;
        Vendor: Record Vendor;
        Customer: Record Customer;
        AccountTypes: Record "Account Type";
        TempFile: File;
        PictureText: text;
        Base64CU: Codeunit "Base64 Convert";
        PicStr: InStream;
        LoanApplication: Record "Loan Application";
        hasaccounts: Boolean;
        Found: Boolean;
        LoanProductTypes: Record "Loan Product Type";
        NoofInstallments: Decimal;
    begin
        Member.RESET;
        Member.SETRANGE("National ID", Idnumber);
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
                                '","MemberImage" : "Image Not Found' +
                                '"}, "accounts" :[';

                REPEAT
                    Vendor.CalcFields(Balance);
                    accountTypes.RESET;
                    accountTypes.SETRANGE(Code, Vendor."Account Type");
                    IF accountTypes.FINDFIRST THEN BEGIN
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
            END;

            LoanApplication.Reset();
            LoanApplication.SetRange("Member No.", Member."No.");
            LoanApplication.SetRange(Posted, true);
            if LoanApplication.FindSet() then begin
                Found := false;
                hasaccounts := FALSE;
                REPEAT
                    LoanApplication.CalcFields("Outstanding Balance");
                    If LoanApplication."Outstanding Balance" > 0 then begin
                        NoofInstallments := 0;
                        if LoanApplication."Disbursal Date" = 0D then begin
                            LoanApplication."Disbursal Date" := LoanApplication."Approved Date";
                            LoanApplication.Modify();
                            Commit();
                        end;
                        //Error('Loan %1..disb %2...comple %3..appr %4', LoanApplication."No.", LoanApplication."Disbursal Date", LoanApplication."Date of Completion", LoanApplication."Approved Date");
                        NoofInstallments := GetNoofInstallments(LoanApplication."No.", LoanApplication."Disbursal Date", LoanApplication."Date of Completion");

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
                                                    '","noofInstallments" : "' + FORMAT(NoofInstallments) +
                                                    '","tofinishdate" : "' + FORMAT(LoanApplication."Date of Completion") +
                                                '"},';
                                hasaccounts := TRUE;
                            END;
                        END;
                    end;
                UNTIL LoanApplication.NEXT = 0;
            end;
            ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
            ResponseMessage += ']}';
            EXIT;
        end
    end;

    procedure PinnoCash(VAR request_id: Code[10]; VAR phone_no: Code[50]; VAR transaction_type: Integer; VAR amount: Text; VAR trnx_charges: Text; VAR "account _number": Code[50]; VAR cr_account: Code[50]; VAR status: Text[50]; VAR f_key: Code[50]; VAR balance: Text;
                        VAR message: Text[500]; VAR response: Text[50]; VAR "response message": Text[1024]; VAR agent_phone_no: Code[50]; VAR customerType: Code[20]; VAR description: Text[100])

    var
        LoanAccount: Boolean;
        BankAccount: Record "Bank Account";
        TransactionAmount: Decimal;
        Acctype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        PostDesc: Text;
        Member: Record Member;
        Member2: Record Member;
        MobileBankingEntries: Record "Mobile Banking Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Vendor: Record Vendor;
        JournalTemplateName: Code[20];
        JournalBatchName: Code[20];
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        Mobilesetup: Record "Mobile Banking Setup";
        AccountTypes: Record "Account Type";
        Customer: Record Customer;
        CustomerRec: Record Customer;
        TotalMiniTransactions: BigText;
        MobileBankingMember: Record "Mobile Banking Member";
    begin
        if StrLen(description) > 50 then begin
            response := '14';
            "response message" := 'description should be less than 50 characters';
            exit;
        end;
        AgencySetup.Get();
        AgentAccs.Reset();
        AgentAccs.SetRange("Phone No.", agent_phone_no);
        AgentAccs.SetRange(Status, AgentAccs.Status::Active);
        if AgentAccs.FindFirst() then begin
            AgentNo := AgentAccs."Member No.";
            AgentAccountType := AgentAccountType::"Bank Account";
            AgentAccNo := AgentAccs."Account No.";
        end else begin
            response := '22';
            "response message" := 'Agent Account Not Found';
            exit;
        end;

        Member.RESET;
        Member.SETRANGE("Phone No.", phone_no);
        IF NOT Member.FINDSET THEN BEGIN
            "response message" := 'Provided Phone: ' + phone_no + ' is invalid!';
            response := '10';
            EXIT;
        END else begin
            // MobileBankingMember.RESET;
            // MobileBankingMember.SETRANGE("Phone No.", Member."Phone No.");
            // MobileBankingMember.SETRANGE(Status, MobileBankingMember.Status::Active);
            // MobileBankingMember.SetFilter("Service Type", '%1|%2', MobileBankingMember."Service Type"::"Agency Banking", MobileBankingMember."Service Type"::Both);
            // IF NOT MobileBankingMember.FINDFIRST THEN BEGIN
            //     "response message" := 'Provided Phone: ' + phone_no + ' is not registered for mobile banking';
            //     response := '10';
            //     EXIT;
            // END;
            Member2.Reset();
            Member2.SetRange("Phone No.", Member."Phone No.");
            if Member2.FindSet() then begin
                if Member2.Count = 1 then begin
                    if "account _number" <> '' then begin
                        if Vendor.get("account _number") then begin
                            if Vendor."Member No." <> Member."No." then begin
                                response := '14';
                                "response message" := 'The Phone no. and Account No. do not belong to the same member';
                                EXIT;
                            end;
                        end;
                    end;
                    if cr_account <> '' then begin
                        if Vendor.get(cr_account) then begin
                            if Vendor."Member No." <> Member."No." then begin
                                response := '14';
                                "response message" := 'The Phone no. and Account No. do not belong to the same member';
                                EXIT;
                            end;
                        end;
                    end;
                    //end;
                    //CBSSetup.GET;
                    JournalTemplateName := AgencySetup."Agency Template Name";
                    JournalBatchName := AgencySetup."Agency Batch Name";


                    MobileBankingEntries.RESET;
                    MobileBankingEntries.SETRANGE("Transaction No.", request_id);
                    IF MobileBankingEntries.FINDFIRST THEN BEGIN
                        response := '14';
                        "response message" := 'Duplicate transaction';
                        EXIT;
                    END;
                    IF f_key <> '' THEN BEGIN
                        IF transaction_type IN [57] THEN BEGIN
                            MobileBankingEntries.RESET;
                            MobileBankingEntries.SETRANGE(FKey, f_key);
                            IF MobileBankingEntries.FINDFIRST THEN BEGIN
                                response := '14';
                                "response message" := 'Duplicate transaction';
                                EXIT;
                            END;
                        END;
                    END;

                    VendorLedgerEntry.RESET;
                    VendorLedgerEntry.SETRANGE("Document No.", request_id);
                    IF VendorLedgerEntry.FINDFIRST THEN BEGIN
                        response := '14';
                        "response message" := 'Duplicate transaction';
                        EXIT;
                    END;
                    Vendor.RESET;
                    Vendor.SETRANGE("No.", "account _number");
                    IF NOT Vendor.FINDFIRST THEN BEGIN
                        if Vendor.Status = Vendor.Status::Active then begin
                            if (transaction_type = 57) or (transaction_type = 63) then begin
                                response := '14';
                                "response message" := 'Account number is not active';
                                EXIT;
                            end
                        end;
                    END;
                    IF transaction_type IN [56] THEN BEGIN
                        Vendor.RESET;
                        Vendor.SETRANGE("No.", "account _number");
                        IF NOT Vendor.FINDFIRST THEN BEGIN
                            response := '14';
                            "response message" := 'Account number does not exist';
                            EXIT;
                        END;
                    END;

                    GenJournalLine.Reset();
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplateName);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatchName);
                    if GenJournalLine.FindSet() then begin
                        GenJournalLine.DeleteAll();
                    end;

                    IF NOT GenJournalBatch.GET(JournalTemplateName, JournalBatchName) THEN BEGIN
                        GenJournalBatch.INIT;
                        GenJournalBatch."Journal Template Name" := JournalTemplateName;
                        GenJournalBatch.Name := JournalBatchName;
                        GenJournalBatch.INSERT;
                    END;
                    Mobilesetup.Get();

                    //Member Balance Inquiry
                    IF transaction_type = 58 THEN BEGIN
                        Vendor.RESET;
                        Vendor.SetRange("No.", "account _number");
                        IF Vendor.FindFirst() THEN BEGIN
                            // AccountTypes.RESET;
                            // AccountTypes.SETRANGE(Code, Vendor."Account Type");
                            // IF NOT AccountTypes.FINDSET THEN BEGIN
                            //     {
                            //         response := '14';
                            //     "response message" := 'This Account is not a Savings Account';
                            //     EVALUATE(TransactionAmount, amount);
                            //     CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                            //     EXIT;
                            //     }
                            // END;
                            response := '00';
                            "response message" := FORMAT(GetMemberBalance("account _number"));
                        END;
                        //EVALUATE(TransactionAmount, amount);
                        /*IF checkTotalCharges(58, TransactionAmount) > CheckAvailableAmount(58, phone_no, 1, "account _number") THEN BEGIN
                            response := '01';
                            "response message" := 'Insufficient Balance';
                            EXIT;
                        END;*/
                        Customer.Reset();
                        Customer.SetRange("No.", "account _number");
                        If Customer.FindFirst() then begin
                            response := '00';
                            "response message" := FORMAT(GetCustomerBalance("account _number"));
                        end;

                        //EVALUATE(TransactionAmount, amount);
                        //CreateMobileBankingEntries(request_id, message, phone_no, 700, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                        addAgencyLog(request_id, phone_no, TransactionAmount, "account _number", agent_phone_no, transaction_type);
                        EXIT;
                    END;
                    IF transaction_type = 57 THEN BEGIN
                        PostDesc := 'Agency Banking deposit -' + ' Member No- ' + Member."No.";
                        response := '00';
                        "response message" := 'Deposit Successful';
                        EVALUATE(TransactionAmount, amount);
                        AccType := AccType::"Bank Account";
                        BalAccType := BalAccType::Vendor;

                        CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AgentAccountType, AgentAccNo, '', PostDesc,
                            TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key, '');
                        CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                        -TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key, '');

                        //CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);
                        addAgencyLog(request_id, phone_no, TransactionAmount, "account _number", agent_phone_no, transaction_type);
                        PostTransaction(JournalTemplateName, JournalBatchName);
                        EXIT;
                    END;
                    IF transaction_type = 56 THEN BEGIN
                        EVALUATE(TransactionAmount, amount);
                        //To remove
                        response := '14';
                        "response message" := 'transaction not enabled';
                        exit;
                        //To remove
                        if getAgentBalance(agent_phone_no) < TransactionAmount then begin
                            response := '01';
                            "response message" := 'The agent has Insufficient Balance';
                            EXIT;
                        end;
                        IF GetMemberBalance("account _number") < TransactionAmount THEN BEGIN
                            response := '01';
                            "response message" := 'Insufficient Account Balance';
                            CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);
                            EXIT;
                        END;
                        IF checkTotalCharges(56, TransactionAmount) > CheckAvailableAmount(56, phone_no, 1, "account _number") THEN BEGIN
                            response := '01';
                            "response message" := 'Insufficient Balance';
                            EXIT;
                        END;

                        PostDesc := 'Agency Withdrawal ';
                        response := '00';
                        "response message" := 'Withdrawal Successful';
                        AccType := AccType::Vendor;
                        BalAccType := BalAccType::Vendor;
                        CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, AgentAccNo, '', PostDesc,
                                        -TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key, '');
                        CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                        TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key, '');

                        if ChargeAmount > 0 then begin
                            PostDesc := 'Agency Withdrawal Charges';
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                        ChargeAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 3, f_key, '');

                            if ChargeAmount <> 0 then begin
                                CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType::"G/L Account", SaccoGL, '', PostDesc,
                                                    -SaccoCharges, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 4, f_key, '');
                            end;
                            if ExciseAmount <> 0 then begin
                                PostDesc := 'Agency Withdrawal Charges (Excise)';
                                CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType::"G/L Account", ExciseGL, '', PostDesc,
                                                    -ExciseAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 5, f_key, '');
                            end;
                            if SettlementAmount <> 0 then begin
                                PostDesc := 'Agency Withdrawal Charges (Settlement Amount)';
                                CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType::"G/L Account", SettlementGL, '', PostDesc,
                                                    -SettlementAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 6, f_key, '');
                            end;
                        end;
                        //CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);
                        addAgencyLog(request_id, phone_no, TransactionAmount, "account _number", agent_phone_no, transaction_type);

                        PostTransaction(JournalTemplateName, JournalBatchName);
                    end;
                end else begin
                    if Member2.Count > 1 then begin
                        repeat
                            if "account _number" <> '' then begin
                                if Vendor.get("account _number") then begin
                                    if Vendor."Member No." = Member2."No." then begin

                                        JournalTemplateName := AgencySetup."Agency Template Name";
                                        JournalBatchName := AgencySetup."Agency Batch Name";

                                        MobileBankingEntries.RESET;
                                        MobileBankingEntries.SETRANGE("Transaction No.", request_id);
                                        IF MobileBankingEntries.FINDFIRST THEN BEGIN
                                            response := '14';
                                            "response message" := 'Duplicate transaction';
                                            EXIT;
                                        END;
                                        IF f_key <> '' THEN BEGIN
                                            IF transaction_type IN [57] THEN BEGIN
                                                MobileBankingEntries.RESET;
                                                MobileBankingEntries.SETRANGE(FKey, f_key);
                                                IF MobileBankingEntries.FINDFIRST THEN BEGIN
                                                    response := '14';
                                                    "response message" := 'Duplicate transaction';
                                                    EXIT;
                                                END;
                                            END;
                                        END;

                                        VendorLedgerEntry.RESET;
                                        VendorLedgerEntry.SETRANGE("Document No.", request_id);
                                        IF VendorLedgerEntry.FINDFIRST THEN BEGIN
                                            response := '14';
                                            "response message" := 'Duplicate transaction';
                                            EXIT;
                                        END;

                                        GenJournalLine.Reset();
                                        GenJournalLine.SetRange("Journal Template Name", JournalTemplateName);
                                        GenJournalLine.SetRange("Journal Batch Name", JournalBatchName);
                                        if GenJournalLine.FindSet() then begin
                                            GenJournalLine.DeleteAll();
                                        end;

                                        IF NOT GenJournalBatch.GET(JournalTemplateName, JournalBatchName) THEN BEGIN
                                            GenJournalBatch.INIT;
                                            GenJournalBatch."Journal Template Name" := JournalTemplateName;
                                            GenJournalBatch.Name := JournalBatchName;
                                            GenJournalBatch.INSERT;
                                        END;
                                        Mobilesetup.Get();

                                        //Member Balance Inquiry
                                        IF transaction_type = 58 THEN BEGIN
                                            Vendor.RESET;
                                            Vendor.SetRange("No.", "account _number");
                                            IF Vendor.FindFirst() THEN BEGIN
                                                // AccountTypes.RESET;
                                                // AccountTypes.SETRANGE(Code, Vendor."Account Type");
                                                // IF NOT AccountTypes.FINDSET THEN BEGIN
                                                //     {
                                                //         response := '14';
                                                //     "response message" := 'This Account is not a Savings Account';
                                                //     EVALUATE(TransactionAmount, amount);
                                                //     CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                                                //     EXIT;
                                                //     }
                                                // END;
                                                response := '00';
                                                "response message" := FORMAT(GetMemberBalance("account _number"));
                                            END;
                                            //EVALUATE(TransactionAmount, amount);
                                            /*IF checkTotalCharges(58, TransactionAmount) > CheckAvailableAmount(58, phone_no, 1, "account _number") THEN BEGIN
                                                response := '01';
                                                "response message" := 'Insufficient Balance';
                                                EXIT;
                                            END;*/
                                            Customer.Reset();
                                            Customer.SetRange("No.", "account _number");
                                            If Customer.FindFirst() then begin
                                                response := '00';
                                                "response message" := FORMAT(GetCustomerBalance("account _number"));
                                            end;
                                            addAgencyLog(request_id, phone_no, TransactionAmount, "account _number", agent_phone_no, transaction_type);
                                            EXIT;
                                        END;
                                        IF transaction_type = 57 THEN BEGIN
                                            PostDesc := 'Agency Banking deposit -' + ' Member No- ' + Member2."No.";
                                            response := '00';
                                            "response message" := 'Deposit Successful';
                                            EVALUATE(TransactionAmount, amount);
                                            AccType := AccType::"Bank Account";
                                            BalAccType := BalAccType::Vendor;

                                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AgentAccountType, AgentAccNo, '', PostDesc,
                                                TransactionAmount, Member2."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member2."No.", Today, 1, f_key, '');
                                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                                            -TransactionAmount, Member2."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member2."No.", Today, 2, f_key, '');

                                            //CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);
                                            addAgencyLog(request_id, phone_no, TransactionAmount, "account _number", agent_phone_no, transaction_type);
                                            PostTransaction(JournalTemplateName, JournalBatchName);
                                            EXIT;
                                        END;
                                        IF transaction_type = 56 THEN BEGIN
                                            EVALUATE(TransactionAmount, amount);
                                            //To remove
                                            response := '14';
                                            "response message" := 'transaction not enabled';
                                            exit;
                                            //To remove
                                            if getAgentBalance(agent_phone_no) < TransactionAmount then begin
                                                response := '01';
                                                "response message" := 'The agent has Insufficient Balance';
                                                EXIT;
                                            end;
                                            IF GetMemberBalance("account _number") < TransactionAmount THEN BEGIN
                                                response := '01';
                                                "response message" := 'Insufficient Account Balance';
                                                CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);
                                                EXIT;
                                            END;
                                            IF checkTotalCharges(56, TransactionAmount) > CheckAvailableAmount(56, phone_no, 1, "account _number") THEN BEGIN
                                                response := '01';
                                                "response message" := 'Insufficient Balance';
                                                EXIT;
                                            END;

                                            PostDesc := 'Agency Withdrawal ';
                                            response := '00';
                                            "response message" := 'Withdrawal Successful';
                                            AccType := AccType::Vendor;
                                            BalAccType := BalAccType::Vendor;
                                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, AgentAccNo, '', PostDesc,
                                                            -TransactionAmount, Member2."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member2."No.", Today, 1, f_key, '');
                                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                                            TransactionAmount, Member2."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member2."No.", Today, 2, f_key, '');

                                            if ChargeAmount > 0 then begin
                                                PostDesc := 'Agency Withdrawal Charges';
                                                CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                                            ChargeAmount, Member2."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member2."No.", Today, 3, f_key, '');

                                                if ChargeAmount <> 0 then begin
                                                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType::"G/L Account", SaccoGL, '', PostDesc,
                                                                        -SaccoCharges, Member2."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member2."No.", Today, 4, f_key, '');
                                                end;
                                                if ExciseAmount <> 0 then begin
                                                    PostDesc := 'Agency Withdrawal Charges (Excise)';
                                                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType::"G/L Account", ExciseGL, '', PostDesc,
                                                                        -ExciseAmount, Member2."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member2."No.", Today, 5, f_key, '');
                                                end;
                                                if SettlementAmount <> 0 then begin
                                                    PostDesc := 'Agency Withdrawal Charges (Settlement Amount)';
                                                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType::"G/L Account", SettlementGL, '', PostDesc,
                                                                        -SettlementAmount, Member2."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member2."No.", Today, 6, f_key, '');
                                                end;
                                            end;
                                            //CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);
                                            addAgencyLog(request_id, phone_no, TransactionAmount, "account _number", agent_phone_no, transaction_type);

                                            PostTransaction(JournalTemplateName, JournalBatchName);
                                        end;
                                    end;
                                end;
                            end;
                        until Member2.Next = 0;
                    end;
                end;
            end;
        end;
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
                        TransAmount, Customer."Global Dimension 1 Code", BalType::"G/L Account", '', Customer."Member No.", Today, 1, RequestID2, '');
        CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID2, BalType, BalAccNo, '', DescriptionTxt,
                        -TransAmount, Customer."Global Dimension 1 Code", BalType::"G/L Account", '', Customer."Member No.", Today, 2, RequestID2, '');

    end;

    local procedure CreateJnlLine(JournalTemplateName: Code[20]; JournalBatchName: Code[20]; RequestID: Code[20]; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[30]; TransactionTypes: Code[10]; Description: Text[50]; PostingAmount: Decimal; GlobalDimensionCode: Code[20]; BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; BalAccountNo: Code[30]; MemberNo: Code[20]; PostingDate: Date; LineNo: Integer; F_key: code[40]; PostingGP: Code[100])
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
        If PostingGP <> '' then
            TempGenJournalLine."Posting Group" := PostingGP;
        TempGenJournalLine.VALIDATE(TempGenJournalLine.Amount, PostingAmount);
        //TempGenJournalLine.VALIDATE("Shortcut Dimension 1 Code",Globaldim);s
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

    local procedure CreateMobileBankingEntries(RequestID: Code[20]; Message: Text; PhoneNo: Code[20]; TransactionType: Integer; AmountT: Decimal; ChargesT: Decimal; Account_number: Code[50]; Cr_Account: Code[50]; F_Key: code[20])
    var
        MobileBankingEntries: Record "Mobile Banking Ledger Entry";
        MobileBankingEntries2: Record "Mobile Banking Ledger Entry";
        LastEntryNo: Integer;
    begin
        LastEntryNo := 1;
        MobileBankingEntries2.Reset();
        MobileBankingEntries2.SetFilter("Entry No.", '<>%1', 0);
        if MobileBankingEntries2.FindLast() then begin
            LastEntryNo := MobileBankingEntries2."Entry No." + 1;
        end;
        MobileBankingEntries.INIT;
        MobileBankingEntries."Entry No." := LastEntryNo;
        MobileBankingEntries."Transaction No." := RequestID;
        MobileBankingEntries.Description := Message;
        //MobileBankingEntries."Charge Description":=PhoneNo;lg
        MobileBankingEntries."Service ID" := TransactionType;
        MobileBankingEntries.Validate("Service ID");
        MobileBankingEntries.Amount := AmountT;
        MobileBankingEntries."Phone No." := PhoneNo;
        MobileBankingEntries."Account No." := Account_number;
        MobileBankingEntries."CR Account No." := Cr_Account;
        MobileBankingEntries."Transaction Date" := TODAY;
        MobileBankingEntries."Transaction Time" := TIME;
        MobileBankingEntries."Transacted By" := USERID;
        MobileBankingEntries.FKey := F_Key;
        MobileBankingEntries.INSERT;
    end;

    local procedure checkTotalCharges(Transaction_Type: Integer; Amount: Decimal) TotalCharges: Decimal
    var
        TransactionTypes: Record "Transaction -Type";
        Charge: Record Charge;
    begin
        TotalCharges := 0;
        TransactionTypes.RESET;
        IF Transaction_Type = 58 THEN BEGIN
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
        IF Transaction_Type = 57 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Agency Deposit");
        END;
        IF Transaction_Type = 56 THEN BEGIN
            TransactionTypes.SETRANGE(Type, TransactionTypes.Type::"Agency Withdrawal");
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
            IF Charge.FindFirst THEN BEGIN
                if (Charge."Charge Amount" <> 0) and (charge."GL Account" <> '') then begin
                    SaccoCharges := Charge."Charge Amount";
                    SaccoGL := Charge."GL Account";
                end;
                if (Charge."Excise %" <> 0) and (charge."Excise G/L Account" <> '') then begin
                    ExciseAmount := (Charge."Excise %" * Charge."Charge Amount") / 100;
                    ExciseGL := Charge."Excise G/L Account";
                end;
                //SettlementAmount := Charge."Settlement Amount";
                BankAccount.RESET;
                BankAccount.SETRANGE("Paybill Bank", TRUE);
                IF BankAccount.FINDFIRST THEN BEGIN
                    //SettlementGL := BankAccount."No.";
                END;
                if (Charge."Pinno Amount" <> 0) and (Charge."Pinno Account" <> '') then begin
                    SettlementAmount := Charge."Pinno Amount";
                    SettlementGL := charge."Pinno Account";
                end;
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

    LOCAL procedure GetMemberBalance(AccountNo: Code[20]) MemberAccountBalance: Decimal
    var
        Vendor: Record Vendor;

    begin
        IF Vendor.GET(AccountNo) THEN BEGIN
            Vendor.CALCFIELDS("Balance (LCY)");
            MemberAccountBalance := ABS(Vendor."Balance (LCY)");
            EXIT(MemberAccountBalance);
        END;
    end;

    LOCAL procedure GetCustomerBalance(AccountNo: Code[20]) MemberAccountBalance: Decimal
    var
        CustomerRec: Record Customer;
    begin
        IF CustomerRec.GET(AccountNo) THEN BEGIN
            CustomerRec.CALCFIELDS("Balance (LCY)");
            MemberAccountBalance := ABS(CustomerRec."Balance (LCY)");
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


    local procedure PrepareLoanJournal(AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccNo: Code[20]; BalType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; BalAccNo: Code[20]; TransAmount: Decimal; RequestID2: Code[20]; DescriptionTxt: text; PhoneNo: Text; f_key: Text)

    var
        InterestDue: decimal;
        LedgerFeeDue: decimal;
        PenaltyDue: decimal;
        PrincipalDue: Decimal;
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
        LoanAc: Record "Loan Application";
        LProdSetup: Record "Loan Product Type";
        postingDate: Date;
        Member: Record Member;
        SavingsAcc: Code[20];
        TransactionTypeCodeSetup: Record "Transaction Type Code Setup";
        TType: Option " ",Deposit,Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Shares Contribution","Welfare Contribution","Registration Fee","Administration Fee",Dividend,"Withholding Tax","Loan Adjustment";
    begin
        //CBSSetup.GET;
        JournalTemplateName := 'GENERAL';
        JournalBatchName := 'PINNOCASH';
        GetLoanBalances(BalAccNo, PrincipalDue, InterestDue, LedgerFeeDue, PenaltyDue);
        ToSavings := 0;
        AmountBalance := TransAmount;
        //ERROR('Interest %1,prin %2,Sav %3, savin acc %4',InterestDue,PrincipalDue,ToSavings,SavingsAcc);
        IF InterestDue > 0 THEN BEGIN
            IF InterestDue >= TransAmount THEN BEGIN
                InterestDue := TransAmount;
                LedgerFeeDue := 0;
                PenaltyDue := 0;
                PrincipalDue := 0;
                AmountBalance := 0;
            END ELSE BEGIN
                AmountBalance -= InterestDue;
            END;
        END ELSE BEGIN
            InterestDue := 0;
        END;

        IF LedgerFeeDue > 0 THEN BEGIN
            IF LedgerFeeDue >= TransAmount THEN BEGIN
                LedgerFeeDue := TransAmount;
                PenaltyDue := 0;
                PrincipalDue := 0;
                AmountBalance := 0;
            END ELSE BEGIN
                AmountBalance -= LedgerFeeDue;
            END;
        END ELSE BEGIN
            LedgerFeeDue := 0;
        END;

        IF PenaltyDue > 0 THEN BEGIN
            IF PenaltyDue >= TransAmount THEN BEGIN
                PenaltyDue := TransAmount;
                PrincipalDue := 0;
                AmountBalance := 0;
            END ELSE BEGIN
                AmountBalance -= PenaltyDue;
            END;
        END ELSE BEGIN
            PenaltyDue := 0;
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

        ToSavings := AmountBalance;
        //ERROR('Interest %1,prin %2,Sav %3, savin acc %4',InterestDue,PrincipalDue,ToSavings,SavingsAcc);
        RequestID := RequestID2;
        AccountType := AccType;
        AccountNo := AccNo;
        BalAccountType := BalAccountType::"Bank Account";
        BalAccountNo := '';
        PostingDate := TODAY;
        Amount := TransAmount;
        Member.RESET;
        Member.SETRANGE("Phone No.", PhoneNo);
        IF Member.FINDSET THEN BEGIN
            MemberNo := Member."No.";
            GlobalDimensionCode := Member."Global Dimension 1 Code";
        END;

        TransactionTypeCodeSetup.Get();
        SavingsAcc := GetSavingsAccount(MemberNo);
        If LoanAc.Get(BalAccountNo) THEN
            LProdSetup.Get(LoanAc."Loan Product Type");

        IF InterestDue > 0 THEN BEGIN
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, TransactionTypeCodeSetup."Interest Paid", 'Mobile Interest Repayment - ' + Format(f_key),
                            InterestDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 1, f_key, '');
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, TransactionTypeCodeSetup."Interest Paid", 'Mobile Interest Repayment - ' + Format(f_key),
                            -InterestDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 2, f_key, LProdSetup."Interest Due Posting Group");
        END;
        IF LedgerFeeDue > 0 THEN BEGIN
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, TransactionTypeCodeSetup."Ledger Fee Paid", 'Mobile Ledger Fee Repayment - ' + Format(f_key),
                            LedgerFeeDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 3, f_key, '');
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, TransactionTypeCodeSetup."Ledger Fee Paid", 'Mobile Ledger Fee Repayment - ' + Format(f_key),
                            -LedgerFeeDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 4, f_key, LProdSetup."Ledger Fee Due Posting Group");
        END;
        IF InterestDue > 0 THEN BEGIN
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, TransactionTypeCodeSetup."Penalty Paid", 'Mobile Penalty Repayment - ' + Format(f_key),
                            PenaltyDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 5, f_key, '');
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, TransactionTypeCodeSetup."Penalty Paid", 'Mobile Penalty Repayment - ' + Format(f_key),
                            -PenaltyDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 6, f_key, LProdSetup."Penalty Due Posting Group");
        END;
        IF PrincipalDue > 0 THEN BEGIN
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, TransactionTypeCodeSetup."Principal Paid", 'Mobile Principal Repayment - ' + Format(f_key),
                            PrincipalDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 7, f_key, '');
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, TransactionTypeCodeSetup."Principal Paid", 'Mobile Principal Repayment - ' + Format(f_key),
                            -PrincipalDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 8, f_key, LProdSetup."Loan Posting Group");
        END;
        IF (ToSavings > 0) AND (SavingsAcc <> '') THEN BEGIN
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, '', STRSUBSTNO('Loan %1 OverRecovery - ', BalAccNo) + Format(f_key),
                            ToSavings, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 9, f_key, '');
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Vendor, SavingsAcc, '', STRSUBSTNO('Loan %1 OverRecovery - ', BalAccNo) + Format(f_key),
                            -ToSavings, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 10, f_key, '');
        END;
    end;

    local procedure GetLoanBalances(LoanNo: Code[20]; VAR PrincipalDue: Decimal; VAR InterestDue: Decimal; VAR LedgerFeeDue: Decimal; VAR PenaltyDue: Decimal)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedger: Record "Detailed Cust. Ledg. Entry";
        TransactionTypeSetup: Record "Transaction Type Code Setup";
    begin
        TransactionTypeSetup.Get();
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
                IF DetailedCustLedger."Transaction Type Code" IN [TransactionTypeSetup."New Loan", TransactionTypeSetup."Principal Paid", ''] THEN BEGIN
                    PrincipalDue += DetailedCustLedger.Amount;
                END;
                IF DetailedCustLedger."Transaction Type Code" IN [TransactionTypeSetup."Interest Paid", TransactionTypeSetup."Interest Due"] THEN BEGIN
                    InterestDue += DetailedCustLedger.Amount;
                END;
                IF DetailedCustLedger."Transaction Type Code" IN [TransactionTypeSetup."Ledger Fee Paid", TransactionTypeSetup."Ledger Fee Due"] THEN BEGIN
                    LedgerFeeDue += DetailedCustLedger.Amount;
                END;
                IF DetailedCustLedger."Transaction Type Code" IN [TransactionTypeSetup."Penalty Paid", TransactionTypeSetup."Penalty Due"] THEN BEGIN
                    PenaltyDue += DetailedCustLedger.Amount;
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
        AccountTypes.SETRANGE(Type, AccountTypes.Type::"Member Deposit");
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

    local procedure getAgentBalance(AgentPhoneNo: Code[20]) AccBalance: Decimal
    var
    begin
        BankAcc.Reset();
        BankAcc.SetRange(Agent, true);
        BankAcc.SetRange("Agent Phone No.", AgentPhoneNo);
        if BankAcc.FindFirst() then begin
            BankAcc.CalcFields(Balance);
            AccBalance := BankAcc.Balance;
            exit(AccBalance);
        end;
    end;

    local procedure addAgencyLog(RequestID: Code[20]; PhoneNO: code[20]; TransactionAmount: Decimal; AccountNumber: code[20]; AgentPhoneNo: code[20]; TransactionType: Integer)
    var
        AgencyLogEntry: Record "Agency Ledger Entry";
        AgencyLogEntry2: Record "Agency Ledger Entry";
        Vendor: Record Vendor;
        Bank: Record "Bank Account";
    begin
        AgencyLogEntry2.Reset();
        AgencyLogEntry2.SetRange("Request ID.", RequestID);
        if not AgencyLogEntry2.FindFirst() then begin
            AgentAccs.Reset();
            AgentAccs.SetRange("Phone No.", AgentPhoneNo);
            AgentAccs.SetRange(Status, AgentAccs.Status::Active);
            if AgentAccs.FindFirst() then begin
                AgencyLogEntry.Init();
                AgencyLogEntry."Entry No." := getLastEntryNo() + 1;
                AgencyLogEntry."Request ID." := RequestID;
                AgencyLogEntry."Transaction Date" := today;
                AgencyLogEntry."Transaction Time" := time;
                AgencyLogEntry."Agent No." := AgentAccs."Member No.";
                AgencyLogEntry."Agent Name" := AgentAccs."Member Name";
                AgencyLogEntry."Account No." := AccountNumber;
                if Bank.get(AccountNumber) then begin
                    AgencyLogEntry."Account Name" := Bank.Name;
                    AgencyLogEntry."Member No." := AgentAccs."Member No.";
                    AgencyLogEntry."Member Name." := AgentAccs."Member Name";
                end;

                AgencyLogEntry.Amount := TransactionAmount;
                AgencyLogEntry."Transaction Type." := format(TransactionType);
                AgencyLogEntry.Insert();
            end;
        end;
    end;

    local procedure getLastEntryNo() LastNo: Integer
    var
        AgencyLogEntry: Record "Agency Ledger Entry";
    begin
        AgencyLogEntry.Reset();
        if AgencyLogEntry.FindLast() then
            exit(AgencyLogEntry."Entry No.")
        else
            exit(1);
    end;

    procedure GetAgentStatement(VAR AgentPhoneNo: Text; VAR startDate: Date; VAR endDate: Date; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) success: Integer
    var
        AgentFloatAcc: Code[20];
        Vendor: record Vendor;
        Vendor2: record Vendor;
        Member: record Member;
        Bank: Record "Bank Account";
        Bank2: Record "Bank Account";
        transactiondata: Text;
    begin
        AgencyBanking.RESET;// AgencyBanking.
        AgencyBanking.SETRANGE("Phone No.", AgentPhoneNo);
        IF AgencyBanking.FINDFIRST THEN BEGIN
            AgentFloatAcc := AgencyBanking."Account No.";
            IF Bank.GET(AgentFloatAcc) THEN BEGIN
                BankLedgerEntry.RESET;
                BankLedgerEntry.SETRANGE("Bank Account No.", Bank."No.");
                BankLedgerEntry.SETRANGE("Posting Date", startDate, endDate);
                BankLedgerEntry.SETRANGE(Reversed, FALSE);
                IF BankLedgerEntry.FINDSET THEN BEGIN
                    BankLedgerEntry2.RESET;
                    BankLedgerEntry2.SETRANGE("Document No.", BankLedgerEntry."Document No.");
                    BankLedgerEntry2.SETRANGE("Posting Date", BankLedgerEntry."Posting Date");
                    BankLedgerEntry2.SETFILTER("Bank Account No.", '<>%1', Bank."No.");
                    IF BankLedgerEntry2.FINDSET THEN BEGIN
                        IF Bank2.GET(BankLedgerEntry2."Bank Account No.") THEN BEGIN
                            //Member.GET(Vendor2."Member No.");
                        END;
                    END;
                    transactiondata := '{"Transactions":[';
                    REPEAT
                        //BankLedgerEntry.CALCFIELDS(Amount);
                        transactiondata +=
                              '{"transactionID" :"' + FORMAT(BankLedgerEntry."Document No.") +
                              '","postingDate" :"' + FORMAT(BankLedgerEntry."Posting Date") +
                              '","description" : "' + FORMAT(BankLedgerEntry.Description) +
                              '","amount" : "' + FORMAT(BankLedgerEntry.Amount) + '"},';
                    UNTIL BankLedgerEntry.NEXT = 0;
                    transactiondata := COPYSTR(transactiondata, 1, STRLEN(transactiondata) - 1);
                    transactiondata := transactiondata + ']}';
                END;
                ResponseCode := '00';
                ResponseMessage := transactiondata;
                EXIT;
            END ELSE BEGIN
                ResponseCode := '02';
                ResponseMessage := 'Agent Account not found';
                EXIT;
            END;
        END ELSE BEGIN
            ResponseCode := '02';
            ResponseMessage := 'Agent Account not found';
            EXIT;
        END;

    end;

    procedure FetchVehicles(VAR responsecode: Text; VAR responsemessage: Text; VAR ErrorMessage: Text) Success: Integer
    begin

    end;

    procedure Agency(VAR request_id: Code[10]; VAR phone_no: Code[50]; VAR transaction_type: Integer; VAR amount: Text; VAR balance: Text; VAR VehicleNo: Code[20]; VAR response: Text[50]; VAR responsemessage: Text[100]; VAR agent_phone_no: Code[50])
    begin

    end;

    var
        SaccoCharges: Decimal;
        SaccoGL: code[10];
        ExciseAmount: Decimal;
        ExciseGL: code[10];
        SettlementAmount: Decimal;
        SettlementGL: code[10];
        ChargeAmount: Decimal;
        BankAccount: Record "Bank Account";
        AgentAccs: Record Agency;
        BankAcc: Record "Bank Account";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        BankLedgerEntry2: Record "Bank Account Ledger Entry";
        AgencyBanking: Record Agency;
        AgentNo: Code[20];
        AgentAccNo: code[20];
        AgentAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        AgencySetup: Record "Agency Banking Setup";
}
