codeunit 50009 "Mobile Banking"
{
    trigger OnRun()//
    begin

    end;

    procedure SendGETSMSRequest(var SMSEntry: Record "SMS Entry")
    var
        URI: Text;
        ResponseCode: Code[20];
        ResponseMessage: Text[50];
    begin
        with SMSEntry do begin
            BulkSMSSetup.Get();
            URI := 'https://mysms.celcomafrica.com/api/services/sendsms/?apikey=%1&partnerID=%2&message=%3&shortcode=%4&mobile=%5';
            JSONText := StrSubstNo(URI, BulkSMSSetup."API Key", BulkSMSSetup."Partner ID", GetSMSTemplate(), BulkSMSSetup."Short Code", "Phone No.");
            //  Message(JSONText);
            if HttpClient.Get(JSONText, HttpResponseMessage) then begin
                HttpResponseMessage.Content.ReadAs(JSONText);
                ReadJSON(JSONText, ResponseCode, ResponseMessage);
                if ((ResponseCode = '200') and (ResponseMessage = 'Success')) then begin
                    Sent := true;
                    modify;
                end;
            end;
        end;
    end;

    local procedure SendPOSTSMSRequest(URI: Text; QueryObject: Text) responseText: Text;

    var

        client: HttpClient;

        request: HttpRequestMessage;

        response: HttpResponseMessage;

        contentHeaders: HttpHeaders;

        content: HttpContent;

    begin
        // Add the payload to the content
        content.WriteFrom(QueryObject);
        // Retrieve the contentHeaders associated with the content
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        // Assigning content to request.Content will actually create a copy of the content and assign it.
        // After this line, modifying the content variable or its associated headers will not reflect in
        // the content associated with the request message
        request.Content := content;
        request.SetRequestUri(uri);
        request.Method := 'POST';
        client.Send(request, response);
        // Read the response content as json.
        response.Content().ReadAs(responseText);

    end;

    local procedure ReadJSON(JsonString: Text; var ResponseCode: Code[20]; var ResponseMessage: Text[50])
    var
        myInt: Integer;
    begin
        //Create JSONArray String
        //Read and Parse JSONArray
        CLEAR(JSONManagement);
        CLEAR(JObject);

        // JsonString := '{"responses":[{"respose-code":200,"response-code":200,"response-description":"Success","mobile":"254728687217","messageid":213088439,"networkid":"1"}]}';
        JSONManagement.InitializeFromString(JsonString);
        JSONManagement.GetJSONObject(JObject);
        ArrayString := JObject.SelectToken('responses').ToString;

        JSONManagement.InitializeCollection(ArrayString);
        JSONManagement.GetJsonArray(JSONArray);

        //loop and can do insert
        foreach JObject in JSONArray do begin
            ResponseCode := format(JObject.GetValue('respose-code'));
            ResponseMessage := format(JObject.GetValue('response-description'));
        end;
    end;

    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        JSONText: Text;
        HttpContent: HttpContent;
        JSONObject: JsonObject;
        BulkSMSSetup: record "Bulk SMS Setup";
        ArrayString: Text;
        JSONManagement: Codeunit "JSON Management";
        JSONArray: DotNet JArray;
        JObject: DotNet JObject;

    procedure FetchSMSToSend(var ResponseCode: Text; var ResponseMessage: Text; var ErrorMessage: Text)
    var
        SMSEntry: Record "SMS Entry";
        JSONSMSText: Text;
        JSONSMSText2: Text;
        JSONSMSText3: Text;
        Instr: InStream;
    begin
        SMSEntry.RESET;
        SMSEntry.SETRANGE(Sent, FALSE);
        IF SMSEntry.FINDSET THEN BEGIN
            JSONSMSText := '{"PendingSMS": [';
            REPEAT
                JSONSMSText += '{';
                JSONSMSText += '"Key":';
                JSONSMSText += '"' + FORMAT(SMSEntry."Entry No.") + '",';
                JSONSMSText += '"PhoneNo":';
                JSONSMSText += '"' + FORMAT(SMSEntry."Phone No.") + '",';
                JSONSMSText += '"Message":';
                SMSEntry.CalcFields("SMS Text");
                SMSEntry."SMS Text".CreateInStream(Instr);
                Instr.ReadText(JSONSMSText3);
                JSONSMSText += '"' + JSONSMSText3 + '"},';
            UNTIL SMSEntry.NEXT = 0;
            JSONSMSText2 := COPYSTR(JSONSMSText, 1, STRLEN(JSONSMSText) - 1);
            JSONSMSText2 += ']}';
            ResponseCode := '00';
            ResponseMessage := JSONSMSText2;
            EXIT;
        END ELSE BEGIN
            ResponseCode := '14';
            ResponseMessage := 'No SMS found';
            ErrorMessage := 'No SMS found';
            EXIT;
        END;
    end;

    procedure UpdateSentSMS(VAR SMSKey: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text)
    var
        SMSEntry: Record "SMS Entry";
        SMSKey1: Integer;
    begin
        EVALUATE(SMSKey1, SMSKey);
        SMSEntry.RESET;
        SMSEntry.SETRANGE(Sent, FALSE);
        //SMSEntry.SETRANGE("Phone No",MobilePhoneNo);
        SMSEntry.SETRANGE("Entry No.", SMSKey1);
        IF SMSEntry.FINDSET THEN BEGIN
            SMSEntry.Sent := TRUE;
            SMSEntry.MODIFY(TRUE);
            ResponseCode := '00';
            ResponseMessage := 'Success';
            EXIT;
        END ELSE BEGIN
            SMSEntry.Sent := TRUE;
            ResponseCode := '14';
            ResponseMessage := 'No SMS Found';
            ErrorMessage := 'No SMS Found';
            EXIT;
        END;
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
                //accountTypes.SetFilter("Sub Type", '<>%1|%2', accountTypes."Sub Type"::Virtual, accountTypes."Sub Type"::"Field Collection");
                IF accountTypes.FINDFIRST THEN BEGIN
                    if (accountTypes."Sub Type" <> accountTypes."Sub Type"::Virtual) then begin
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
                    end;
                END;
            UNTIL Vendor.NEXT = 0;
            if Found = true then
                ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
            ResponseMessage += ']}';
            EXIT;
        end;
    end;

    Procedure GetFieldAccounts(VAR PhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    var
        Member: Record Member;
        Member2: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
        Found: Boolean;
    begin
        Member.RESET;
        Member.SETRANGE("Phone No.", PhoneNo);
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
        Member2.SetRange("Phone No.", PhoneNo);
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

    procedure GetCustomerAccounts(VAR MemberID: Text[200]; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    var
        Member: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
        LoanApp: Record "Loan Application";
        FoundAccounts: Boolean;
    begin
        if StrLen(MemberID) = 0 then begin
            ResponseCode := '14';
            ErrorMessage := 'Member No missing';
            exit(0);
        end;

        Member.Reset();
        Member.SetRange("No.", MemberID);

        if not Member.FindFirst() then begin
            ResponseCode := '14';
            ErrorMessage := 'Member does not exist';
            exit(0);
        end;

        ResponseCode := '000';
        ResponseMessage := '{"member":{';
        ResponseMessage +=
            '"memberNo":"' + Member."No." +
            '","name":"' + Member."Full Name" +
            '","nationalId":"' + Member."National ID" +
            '","mobileNo":"' + Member."Phone No." +
            '"}, "accounts":[';

        Vendor.Reset();
        Vendor.SetRange("Member No.", Member."No.");

        FoundAccounts := false;

        if Vendor.FindSet() then begin
            repeat
                Vendor.CalcFields(Balance);

                AccountTypes.Reset();
                AccountTypes.SetRange(Code, Vendor."Account Type");
                AccountTypes.SetFilter(Type, '%1|%2|%3',
                    AccountTypes.Type::Savings,
                    AccountTypes.Type::"Share Capital",
                    AccountTypes.Type::"Member Deposit");

                if AccountTypes.FindFirst() then begin
                    FoundAccounts := true;

                    ResponseMessage +=
                        '{' +
                        '"accountNo":"' + Vendor."No." +
                        '","accountName":"' + Vendor.Name +
                        '","balance":"' + FORMAT(Vendor.Balance) +
                        '"},';
                end;

            until Vendor.Next() = 0;
        end;

        if FoundAccounts then
            ResponseMessage := CopyStr(ResponseMessage, 1, StrLen(ResponseMessage) - 1);

        ResponseMessage += '], "loans":[';

        LoanApp.Reset();
        LoanApp.SetRange("Member No.", Member."No.");
        LoanApp.SetRange(Posted, true);
        LoanApp.SetFilter("Outstanding Balance", '>%1', 0);

        if LoanApp.FindSet() then begin
            repeat
                LoanApp.CalcFields("Outstanding Balance");

                ResponseMessage +=
                    '{' +
                    '"loanNo":"' + LoanApp."No." +
                    '","loanProductType":"' + LoanApp."Loan Product Type" +
                    '","loanName":"' + LoanApp.Description +
                    '","balance":"' + FORMAT(LoanApp."Outstanding Balance") +
                    '"},';

            until LoanApp.Next() = 0;

            ResponseMessage := CopyStr(ResponseMessage, 1, StrLen(ResponseMessage) - 1);
        end;

        ResponseMessage += ']}';

        Success := 1;
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
                                // '","phoneNo" : "' + Member."Phone No." +
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


    procedure GetGroupAccounts(var GroupNo: Text; var ResponseCode: Text; var ResponseMessage: Text; var ErrorMessage: Text) Success: Integer
    var
        GroupMember: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
        LoanApp: Record "Loan Application";
        FoundAccounts: Boolean;
    begin
        GroupMember.Reset();
        GroupMember.SetRange("No.", GroupNo);
        GroupMember.SetRange(Category, GroupMember.Category::Group);

        if not GroupMember.FindFirst() then begin
            ResponseCode := '14';
            ErrorMessage := 'Group does not exist';
            exit(0);
        end;

        if GroupMember.Status <> GroupMember.Status::Active then begin
            ResponseCode := '14';
            ErrorMessage := 'Group not active';
            exit(0);
        end;

        ResponseCode := '000';

        ResponseMessage :=
            '{"group":{' +
            '"groupNo":"' + GroupMember."No." +
            '","name":"' + GroupMember."Full Name" +
            '","phoneNo":"' + GroupMember."Phone No." +
            '"}, "accounts":[';

        Vendor.Reset();
        Vendor.SetRange("Member No.", GroupMember."No.");
        Vendor.SetFilter(Status, '%1|%2|%3',
            Vendor.Status::Dormant,
            Vendor.Status::Active,
            Vendor.Status::Frozen);

        FoundAccounts := false;

        if Vendor.FindSet() then begin
            repeat
                Vendor.CalcFields(Balance);

                AccountTypes.Reset();
                AccountTypes.SetRange(Code, Vendor."Account Type");

                if AccountTypes.FindFirst() then begin
                    FoundAccounts := true;

                    ResponseMessage +=
                        '{' +
                        '"accountNo":"' + Vendor."No." +
                        '","accountName":"' + Vendor.Name +
                        '","canWithdraw":"' + FORMAT(AccountTypes."Allow Withdrawal") +
                        '","canDeposit":"' + FORMAT(AccountTypes."Allow Deposit") +
                        '","balance":"' + FORMAT(Vendor.Balance) +
                        '"},';
                end;

            until Vendor.Next() = 0;
        end;

        if FoundAccounts then
            ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);

        ResponseMessage += '], "loans":[';

        LoanApp.Reset();
        LoanApp.SetRange("Member No.", GroupMember."No.");
        LoanApp.SetRange(Posted, true);
        LoanApp.SetFilter("Outstanding Balance", '>%1', 0);

        if LoanApp.FindSet() then begin
            repeat
                LoanApp.CalcFields("Outstanding Balance");

                ResponseMessage +=
                    '{' +
                    '"loanNo":"' + LoanApp."No." +
                    '","loanProductType":"' + LoanApp."Loan Product Type" +
                    '","loanName":"' + LoanApp.Description +
                    '","balance":"' + FORMAT(LoanApp."Outstanding Balance") +
                    '"},';

            until LoanApp.Next() = 0;

            ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
        end;

        ResponseMessage += ']}';

        Success := 1;
    end;

    /* procedure GetGroupAccounts(var GroupPhoneNo: Text; var ResponseCode: Text; var ResponseMessage: Text; var ErrorMessage: Text) Success: Integer
    var
        GroupMember: Record Member;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Type";
    begin
        GroupMember.Reset();
        GroupMember.SetRange("Phone No.", GroupPhoneNo);
        GroupMember.SetRange(Category, GroupMember.Category::Group);

        if not GroupMember.FindFirst() then begin
            ResponseCode := '14';
            ErrorMessage := 'Group does not exist';
            exit;
        end;

        if GroupMember.Status <> GroupMember.Status::Active then begin
            ResponseCode := '14';
            ErrorMessage := 'Group not active';
            exit;
        end;

        ResponseCode := '000';

        ResponseMessage :=
            '{"group":{' +
            '"groupNo":"' + GroupMember."No." +
            '","name":"' + GroupMember."Full Name" +
            '","phone":"' + GroupMember."Phone No." +
            '"}, "accounts":[';

        Vendor.Reset();
        Vendor.SetRange("Member No.", GroupMember."No.");
        Vendor.SetFilter(Status, '%1|%2|%3',
            Vendor.Status::Dormant,
            Vendor.Status::Active,
            Vendor.Status::Frozen);

        if Vendor.FindSet() then begin
            repeat
                Vendor.CalcFields(Balance);

                AccountTypes.Reset();
                AccountTypes.SetRange(Code, Vendor."Account Type");

                if AccountTypes.FindFirst() then begin
                    ResponseMessage +=
                        '{' +
                        '"accountNo":"' + Vendor."No." +
                        '","accountName":"' + Vendor.Name +
                        '","canWithdraw":"' + FORMAT(AccountTypes."Allow Withdrawal") +
                        '","canDeposit":"' + FORMAT(AccountTypes."Allow Deposit") +
                        '","balance":"' + FORMAT(Vendor.Balance) +
                        '"},';
                end;

            until Vendor.Next() = 0;

            ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
        end;

        ResponseMessage += ']}';
    end; */




    procedure PinnoCash(VAR request_id: Code[40]; VAR phone_no: Code[50]; VAR transaction_type: Integer; VAR amount: Text; VAR trnx_charges: Text; VAR "account _number": Code[50]; VAR cr_account: Code[50]; VAR status: Text[50]; VAR f_key: Code[50]; VAR balance: Text;
                        VAR message: Text[500]; VAR response: Text[50]; VAR "response message": Text[1024]; VAR customerType: Code[20]; VAR description: Text[100]; VAR startDate: Text; VAR endDate: Text; VAR startTime: Text; VAR endTime: Text; VAR emailaddress: Text)

    var
        LoanAccount: Boolean;
        BankAccount: Record "Bank Account";
        TransactionAmount: Decimal;
        Acctype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        PostDesc: Text[1250];
        Member: Record Member;
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
        AccountType: Record "Account Type";
    begin
        Mobilesetup.Get();
        JournalTemplateName := 'GENERAL';
        JournalBatchName := 'PINNOCASH';
        // Registration Fee / Group Registration Fee (transaction type 765)
        // Posts: Dr Paybill Bank, Cr Registration GL Account (branch-specific)
        IF transaction_type = 765 THEN BEGIN
            Member.RESET;
            Member.SETRANGE("No.", "account _number");
            IF NOT Member.FINDSET THEN BEGIN
                "response message" := 'Provided Account Number: ' + "account _number" + ' is invalid!';
                response := '10';
                EXIT;
            END;
            EnsureTransactionTypeExists(765, 'Mobile Registration Fee');
            PostChargeToGL(
                request_id, "account _number", amount, f_key, message,
                transaction_type, 'REG',
                JournalTemplateName, JournalBatchName,
                Member, Mobilesetup,
                response, "response message");
            EXIT;
        END;

        // Penalty (transaction type 769   )
        // Posts: Dr Paybill Bank, Cr Penalty GL Account (branch-specific)
        IF transaction_type = 769 THEN BEGIN
            Member.RESET;
            Member.SETRANGE("No.", "account _number");
            IF NOT Member.FINDSET THEN BEGIN
                "response message" := 'Provided Account Number: ' + "account _number" + ' is invalid!';
                response := '10';
                EXIT;
            END;
            EnsureTransactionTypeExists(769, 'Mobile Penalty Charge');
            PostChargeToGL(
                request_id, "account _number", amount, f_key, message,
                transaction_type, 'PEN',
                JournalTemplateName, JournalBatchName,
                Member, Mobilesetup,
                response, "response message");
            EXIT;
        END;

        IF transaction_type = 700 THEN BEGIN
            Vendor.RESET;
            IF Vendor.GET("account _number") THEN BEGIN
                AccountTypes.RESET;
                AccountTypes.SETRANGE(Code, Vendor."Account Type");
                AccountTypes.SETRANGE(Type, AccountTypes.Type::Savings);
                IF NOT AccountTypes.FINDSET THEN BEGIN
                    response := '14';
                    "response message" := 'This Account is not a Savings Account';
                    EVALUATE(TransactionAmount, amount);
                    CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                    EXIT;
                END;
            END;
            EVALUATE(TransactionAmount, amount);
            IF checkTotalCharges(700, TransactionAmount) > CheckAvailableAmount(700, phone_no, 1, "account _number") THEN BEGIN
                response := '01';
                "response message" := 'Insufficient Balance';
                EXIT;
            END;
            response := '00';
            "response message" := FORMAT(GetMemberBalance("account _number"));
            EVALUATE(TransactionAmount, amount);
            CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
            EXIT;
        END;


        Member.RESET;
        Member.SETRANGE("Phone No.", phone_no);
        IF NOT Member.FINDSET THEN BEGIN
            "response message" := 'Provided Phone: ' + phone_no + ' is invalid!';
            response := '10';
            EXIT;
        END else begin
            IF transaction_type <> 761 THEN BEGIN
                MobileBankingMember.RESET;
                MobileBankingMember.SETRANGE("Phone No.", Member."Phone No.");
                MobileBankingMember.SETRANGE(Status, MobileBankingMember.Status::Active);
                IF NOT MobileBankingMember.FINDFIRST THEN BEGIN
                    "response message" := 'Provided Phone: ' + phone_no + ' is not registered for mobile banking';
                    response := '10';
                    EXIT;
                END;
            END;
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
                if transaction_type <> 761 then begin
                    if Vendor.get(cr_account) then begin
                        if Vendor."Member No." <> Member."No." then begin
                            response := '14';
                            "response message" := 'The Phone no. and Account No. do not belong to the same member';
                            EXIT;
                        end;
                    end;
                end;
            end;

            //CBSSetup.GET;



            MobileBankingEntries.RESET;
            MobileBankingEntries.SETRANGE("Transaction No.", request_id);
            IF MobileBankingEntries.FINDFIRST THEN BEGIN
                response := '14';
                "response message" := 'Duplicate transaction';
                EXIT;
            END;
            IF f_key <> '' THEN BEGIN
                IF transaction_type IN [705] THEN BEGIN
                    MobileBankingEntries.RESET;
                    MobileBankingEntries.SETRANGE(FKey, f_key);
                    IF MobileBankingEntries.FINDFIRST THEN BEGIN
                        response := '14';
                        //"response message" := 'Duplicate transaction';
                        //EXIT;
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

            IF transaction_type IN [706] THEN BEGIN
                Vendor.RESET;
                Vendor.SETRANGE("No.", "account _number");
                IF NOT Vendor.FINDFIRST THEN BEGIN
                    response := '14';
                    "response message" := 'Account number does not exist';
                    EXIT;
                END;
            END;
            //"response message" := 'Account number exist';
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
            // Mobilesetup.Get();

            //Member Balance Inquiry
            IF transaction_type = 700 THEN BEGIN
                Vendor.RESET;
                IF Vendor.GET("account _number") THEN BEGIN
                    AccountTypes.RESET;
                    AccountTypes.SETRANGE(Code, Vendor."Account Type");
                    AccountTypes.SETRANGE(Type, AccountTypes.Type::Savings);
                    IF NOT AccountTypes.FINDSET THEN BEGIN
                        response := '14';
                        "response message" := 'This Account is not a Savings Account';
                        EVALUATE(TransactionAmount, amount);
                        CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                        EXIT;
                    END;
                END;
                EVALUATE(TransactionAmount, amount);
                IF checkTotalCharges(700, TransactionAmount) > CheckAvailableAmount(700, phone_no, 1, "account _number") THEN BEGIN
                    response := '01';
                    "response message" := 'Insufficient Balance';
                    EXIT;
                END;
                response := '00';
                "response message" := FORMAT(GetMemberBalance("account _number"));
                EVALUATE(TransactionAmount, amount);
                CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                EXIT;
            END;

            IF transaction_type = 701 THEN BEGIN
                IF Vendor.GET("account _number") THEN BEGIN
                    AccountTypes.RESET;
                    AccountTypes.SETRANGE(Code, Vendor."Account Type");
                    AccountTypes.SETRANGE(Type, AccountTypes.Type::"Share Capital");
                    IF NOT AccountTypes.FINDSET THEN BEGIN
                        response := '14';
                        "response message" := 'This Account is not a share capital Account';
                        EVALUATE(TransactionAmount, amount);
                        CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                        EXIT;
                    END;
                END;
                response := '00';
                "response message" := FORMAT(GetMemberBalance("account _number"));
                EVALUATE(TransactionAmount, amount);
                CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                EXIT;
            END;

            //Loan Balance
            IF transaction_type = 702 THEN BEGIN
                IF Vendor.GET("account _number") THEN BEGIN
                    response := '14';
                    "response message" := 'This Account is not a Loan Account';
                    EVALUATE(TransactionAmount, amount);
                    CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                    EXIT;
                END;
                IF CustomerRec.GET("account _number") THEN BEGIN
                    response := '00';
                    "response message" := FORMAT(GetCustomerBalance("account _number"));
                    EVALUATE(TransactionAmount, amount);
                    CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                    EXIT;
                END ELSE BEGIN
                    response := '14';
                    "response message" := 'This Account is not a Loan Account';
                    EVALUATE(TransactionAmount, amount);
                    CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                    EXIT;
                END;
            END;

            IF transaction_type = 703 THEN BEGIN
                IF Vendor.GET("account _number") THEN BEGIN
                    AccountTypes.RESET;
                    AccountTypes.SETRANGE(Code, Vendor."Account Type");
                    AccountTypes.SETRANGE(Type, AccountTypes.Type::"Member Deposit");
                    IF NOT AccountTypes.FINDSET THEN BEGIN
                        response := '14';
                        "response message" := 'This Account is not a Deposit Account';
                        EVALUATE(TransactionAmount, amount);
                        CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                        EXIT;
                    END;
                END;
                response := '00';
                "response message" := FORMAT(GetMemberBalance("account _number"));
                EVALUATE(TransactionAmount, amount);
                CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                EXIT;
            END;
            IF transaction_type = 704 THEN BEGIN
                IF CustomerRec.GET("account _number") THEN BEGIN
                    GetLast5LoanTransactions("account _number", TotalMiniTransactions);
                END ELSE BEGIN
                    GetLast5Transactions("account _number", TotalMiniTransactions);
                END;
                response := '00';
                "response message" := FORMAT(TotalMiniTransactions);
                EVALUATE(TransactionAmount, amount);
                CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, ChargeAmount, "account _number", cr_account, f_key);
                EXIT;
            END;
            IF transaction_type = 705 THEN BEGIN
                PostDesc := 'Mobile Banking deposit - ' + Member."No.";
                LoanAccount := FALSE;
                LoanAccount := IsLoanAccount("account _number");
                BankAccount.RESET;
                BankAccount.SETRANGE("No.", Mobilesetup."Paybill Bank");
                IF BankAccount.FINDSET THEN BEGIN
                    response := '00';
                    "response message" := 'Deposit Successful';
                    EVALUATE(TransactionAmount, amount);
                    AccType := AccType::"Bank Account";
                    IF LoanAccount = TRUE THEN BEGIN
                        BalAccType := BalAccType::Customer
                    END ELSE
                        BalAccType := BalAccType::Vendor;
                    IF LoanAccount = TRUE THEN BEGIN
                        PrepareLoanJournal(AccType, BankAccount."No.", BalAccType, "account _number", TransactionAmount, request_id, PostDesc, phone_no, f_key);
                    END ELSE BEGIN
                        ///PrepareJournal(AccType, BankAccount."No.", BalAccType, "account _number", TransactionAmount, request_id, PostDesc, phone_no);
                        CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, BankAccount."No.", '', PostDesc,
                            TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key, '');
                        CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                        -TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key, '');
                    END;
                    CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);

                    PostTransaction(JournalTemplateName, JournalBatchName);

                    IF LoanAccount = TRUE THEN BEGIN
                        SendLoanNotification("account _number", TransactionAmount);
                    END;
                    EXIT;
                END;
                EXIT;
            END;
            IF transaction_type = 706 THEN BEGIN
                IF Vendor.GET("account _number") THEN BEGIN
                    AccountType.Reset();
                    AccountType.SetRange(Code, Vendor."Account Type");
                    AccountType.SetRange("Allow Withdrawal", false);
                    If AccountType.FindFirst() then begin
                        response := '14';
                        "response message" := 'Withdrawal Not Allowed For This Account';
                    end;
                END;

                PostDesc := 'Mobile Banking Withdrawal ';
                BankAccount.RESET;
                BankAccount.SETRANGE("No.", Mobilesetup."Paybill Bank");
                IF BankAccount.FINDSET THEN BEGIN
                    EVALUATE(TransactionAmount, amount);

                    IF GetMemberBalance("account _number") < TransactionAmount THEN BEGIN
                        response := '01';
                        "response message" := 'Insufficient Balance';
                        CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);
                        EXIT;
                    END;
                    EVALUATE(TransactionAmount, amount);
                    IF checkTotalCharges(706, TransactionAmount) > CheckAvailableAmount(706, phone_no, 1, "account _number") THEN BEGIN
                        response := '01';
                        "response message" := 'Insufficient Balance';
                        EXIT;
                    END;
                    response := '00';
                    "response message" := 'Withdrawal Successful';
                    AccType := AccType::"Bank Account";
                    BalAccType := BalAccType::Vendor;
                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, BankAccount."No.", '', PostDesc,
                                    -TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key, '');
                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                    TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key, '');

                    if ChargeAmount > 0 then begin
                        PostDesc := phone_no + ' - Withdrawal Charges';
                        CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                    ChargeAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 3, f_key, '');

                        if ChargeAmount <> 0 then begin
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType::"G/L Account", SaccoGL, '', PostDesc,
                                                -SaccoCharges, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 4, f_key, '');
                        end;
                        if ExciseAmount <> 0 then begin
                            PostDesc := phone_no + ' - Withdrawal Excise';
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType::"G/L Account", ExciseGL, '', PostDesc,
                                                -ExciseAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 5, f_key, '');
                        end;
                        if SettlementAmount <> 0 then begin
                            PostDesc := phone_no + ' - Settlement Amount';
                            CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType::"G/L Account", SettlementGL, '', PostDesc,
                                                -SettlementAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 6, f_key, '');
                        end;
                    end;


                    CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);

                    PostTransaction(JournalTemplateName, JournalBatchName);
                end;
            end;
            //Airtime
            IF transaction_type = 707 THEN BEGIN
                PostDesc := 'Airtime Purchase ';
                BankAccount.RESET;
                BankAccount.SETRANGE("No.", Mobilesetup."Paybill Bank");
                IF BankAccount.FINDSET THEN BEGIN
                    EVALUATE(TransactionAmount, amount);
                    IF GetMemberBalance("account _number") < TransactionAmount THEN BEGIN
                        response := '01';
                        "response message" := 'Insufficient Balance';
                        CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);
                        EXIT;
                    END;
                    response := '00';
                    "response message" := 'Airtime Purchase Successful';
                    AccType := AccType::"Bank Account";
                    BalAccType := BalAccType::Vendor;
                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, BankAccount."No.", '', PostDesc,
                                    -TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key, '');
                    CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                    TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key, '');

                    CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);

                    PostTransaction(JournalTemplateName, JournalBatchName);
                end;
            end;

            IF transaction_type = 761 THEN BEGIN

                EnsureTransactionTypeExists(761, 'Co-operative Bank Deposit');

                PostDesc := 'Co-operative Bank Deposit - ' + Format(f_key) + ' Member No ' + Member."No.";
                LoanAccount := FALSE;
                LoanAccount := IsLoanAccount("account _number");

                IF cr_account = '' THEN BEGIN
                    response := '14';
                    "response message" := 'Co-operative Bank Account not provided';
                    EXIT;
                END;

                BankAccount.RESET;
                BankAccount.SETRANGE("No.", cr_account);
                IF BankAccount.FINDSET THEN BEGIN
                    response := '00';
                    "response message" := 'Deposit Successful';
                    EVALUATE(TransactionAmount, amount);
                    AccType := AccType::"Bank Account";
                    IF LoanAccount = TRUE THEN BEGIN
                        BalAccType := BalAccType::Customer;
                    END ELSE
                        BalAccType := BalAccType::Vendor;

                    IF LoanAccount = TRUE THEN BEGIN
                        PrepareLoanJournal(AccType, BankAccount."No.", BalAccType, "account _number", TransactionAmount, request_id, PostDesc, phone_no, f_key);
                    END ELSE BEGIN
                        CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, AccType, BankAccount."No.", '', PostDesc,
                            TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 1, f_key, '');
                        CreateJnlLine(JournalTemplateName, JournalBatchName, request_id, BalAccType, "account _number", '', PostDesc,
                                        -TransactionAmount, Member."Global Dimension 1 Code", BalAccType::"G/L Account", '', Member."No.", Today, 2, f_key, '');
                    END;
                    CreateMobileBankingEntries(request_id, message, phone_no, transaction_type, TransactionAmount, 0, "account _number", cr_account, f_key);

                    PostTransaction(JournalTemplateName, JournalBatchName);

                    IF LoanAccount = TRUE THEN BEGIN
                        SendLoanNotification("account _number", TransactionAmount);
                    END ELSE BEGIN
                        SendDepositNotification("account _number", TransactionAmount);
                    END;
                    EXIT;
                END;
                EXIT;
            END;
        end;
    END;


    local procedure PostChargeToGL(RequestID: Code[40]; PhoneNo: Code[50]; AmountText: Text; FKey: Code[50]; Msg: Text[500]; TrnxType: Integer; ChargeType: Code[3]; JnlTemplate: Code[20]; JnlBatch: Code[20]; var MemberRec: Record Member; var MobileSetupRec: Record "Mobile Banking Setup"; var ResponseCode: Text[50]; var ResponseMsg: Text[1024])
    var
        MobileChargeGLSetup: Record "Mobile Charge GL Setup";
        BankAccount: Record "Bank Account";
        TransactionAmount: Decimal;
        IncomeGL: Code[20];
        PostDesc: Text[1240];
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        BranchCode: Code[20];
    begin
        BranchCode := MemberRec."Global Dimension 1 Code";

        IF NOT MobileChargeGLSetup.GET(BranchCode) THEN BEGIN
            ResponseCode := '14';
            ResponseMsg := 'Mobile Charge GL Setup not found for branch: ' + BranchCode;
            EXIT;
        END;

        IF ChargeType = 'REG' THEN BEGIN
            MobileChargeGLSetup.TESTFIELD("Registration GL Account");
            IncomeGL := MobileChargeGLSetup."Registration GL Account";
            PostDesc := 'Mobile Reg. Fee,  Member No - ' + MemberRec."No.";
        END ELSE BEGIN
            MobileChargeGLSetup.TESTFIELD("Penalty GL Account");
            IncomeGL := MobileChargeGLSetup."Penalty GL Account";
            PostDesc := 'Mobile Penalty, Member No - ' + MemberRec."No.";
        END;

        BankAccount.RESET;
        BankAccount.SETRANGE("No.", MobileSetupRec."Paybill Bank");
        IF NOT BankAccount.FINDFIRST THEN BEGIN
            ResponseCode := '14';
            ResponseMsg := 'Paybill Bank not configured in Mobile Banking Setup';
            EXIT;
        END;

        EVALUATE(TransactionAmount, AmountText);
        IF TransactionAmount <= 0 THEN BEGIN
            ResponseCode := '14';
            ResponseMsg := 'Amount must be greater than zero';
            EXIT;
        END;

        // Dr Paybill Bank
        CreateJnlLine(JnlTemplate, JnlBatch, RequestID,
            AccType::"Bank Account", BankAccount."No.", '', PostDesc,
            TransactionAmount,
            MemberRec."Global Dimension 1 Code",
            AccType::"G/L Account", '', MemberRec."No.", TODAY, 1, FKey, '');

        // Cr Income GL Account
        CreateJnlLine(JnlTemplate, JnlBatch, RequestID,
            AccType::"G/L Account", IncomeGL, '', PostDesc,
            -TransactionAmount,
            MemberRec."Global Dimension 1 Code",
            AccType::"G/L Account", '', MemberRec."No.", TODAY, 2, FKey, '');

        CreateMobileBankingEntries(RequestID, Msg, PhoneNo, TrnxType, TransactionAmount, 0, '', '', FKey);

        PostTransaction(JnlTemplate, JnlBatch);

        ResponseCode := '00';
        ResponseMsg := 'Charge posted successfully';
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

    local procedure EnsureTransactionTypeExists(ServiceID: Integer; Description: Text[100])
    var
        MobileTransType: Record "Mobile Transaction Type";
    begin
        if not MobileTransType.Get(ServiceID) then begin
            MobileTransType.Init();
            MobileTransType.Code := ServiceID;
            MobileTransType.Description := Description;
            MobileTransType.Insert(true);
        end;
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

    local procedure SendDepositNotification(AccountNo: Code[20]; TransAmount: Decimal)
    var
        MobileSetup: Record "Mobile Banking Setup";
        GlobalM: Codeunit "Global Management";
        SMSText: BigText;
        Vendor: Record Vendor;
        Member: Record Member;
        SourceCodeSetup: Record "Source Code Setup";
        MemberName: array[5] of Text;
        NewBalance: Decimal;
    begin
        SourceCodeSetup.Get();
        MobileSetup.Get();
        Vendor.Get(AccountNo);
        Member.Get(Vendor."Member No.");
        MemberName[2] := CopyStr(Member."Full Name", 1, StrPos(Member."Full Name", ' '));
        NewBalance := GetMemberBalance(AccountNo);
        Clear(SMSText);

        SMSText.AddText(StrSubstNo(MobileSetup."Deposit SMS Template", MemberName[2], TransAmount, AccountNo, NewBalance));
        GlobalM.CreateSMSEntry(Member."Phone No.", SMSText, SourceCodeSetup.Purchases);
    end;

    /*local procedure fnSendSmsAfterAgencyReversal()
    var
    detailedVendLedg:Record "Detailed Vendor Ledg. Entry"
    begin
     [EventSubscriber(ObjectType::Page, Page::"Detailed Vendor Ledg. Entries", 'OnBeforeActionEvent', 'ElementName', false, false)]
     local procedure MyProcedure()
     begin
        
     end;
    end;*/

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

    local procedure CreateJnlLine(JournalTemplateName: Code[20]; JournalBatchName: Code[20]; RequestID: Code[40]; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[30]; TransactionTypes: Code[10]; Description: Text[1024]; PostingAmount: Decimal; GlobalDimensionCode: Code[20]; BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; BalAccountNo: Code[30]; MemberNo: Code[20]; PostingDate: Date; LineNo: Integer; F_key: code[50]; PostingGP: Code[100])
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
        BalAccountType := BalAccountType::"G/L Account";
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
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, TransactionTypeCodeSetup."Interest Paid", 'Mobile Interest Repayment - ' + Format(f_key) + ' Member No ' + Member."No.",
                            InterestDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 1, f_key, '');
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, TransactionTypeCodeSetup."Interest Paid", 'Mobile Interest Repayment - ' + Format(f_key) + ' Member No ' + Member."No.",
                            -InterestDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 2, f_key, LProdSetup."Interest Due Posting Group");
        END;
        IF LedgerFeeDue > 0 THEN BEGIN
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, TransactionTypeCodeSetup."Ledger Fee Paid", 'Mobile Ledger Fee Repayment - ' + Format(f_key) + ' Member No ' + Member."No.",
                            LedgerFeeDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 3, f_key, '');
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, TransactionTypeCodeSetup."Ledger Fee Paid", 'Mobile Ledger Fee Repayment - ' + Format(f_key) + ' Member No ' + Member."No.",
                            -LedgerFeeDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 4, f_key, LProdSetup."Ledger Fee Due Posting Group");
        END;
        IF InterestDue > 0 THEN BEGIN
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, TransactionTypeCodeSetup."Penalty Paid", 'Mobile Penalty Repayment - ' + Format(f_key) + ' Member No ' + Member."No.",
                            PenaltyDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 5, f_key, '');
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, TransactionTypeCodeSetup."Penalty Paid", 'Mobile Penalty Repayment - ' + Format(f_key) + ' Member No ' + Member."No.",
                            -PenaltyDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 6, f_key, LProdSetup."Penalty Due Posting Group");
        END;
        IF PrincipalDue > 0 THEN BEGIN
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, TransactionTypeCodeSetup."Principal Paid", 'Mobile Principal Repayment - ' + Format(f_key) + ' Member No ' + Member."No.",
                            PrincipalDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 7, f_key, '');
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Customer, BalAccNo, TransactionTypeCodeSetup."Principal Paid", 'Mobile Principal Repayment - ' + Format(f_key) + ' Member No ' + Member."No.",
                            -PrincipalDue, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 8, f_key, LProdSetup."Loan Posting Group");
        END;
        IF (ToSavings > 0) AND (SavingsAcc <> '') THEN BEGIN
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType, AccountNo, '', STRSUBSTNO('Loan %1 OverRecovery - ', BalAccNo) + Format(f_key) + ' Member No ' + Member."No.",
                            ToSavings, GlobalDimensionCode, BalAccountType, BalAccountNo, MemberNo, PostingDate, 9, f_key, '');
            CreateJnlLine(JournalTemplateName, JournalBatchName, RequestID, AccountType::Vendor, SavingsAcc, '', STRSUBSTNO('Loan %1 OverRecovery - ', BalAccNo) + Format(f_key) + ' Member No ' + Member."No.",
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

    procedure ProcessAutomationsInterest(var RunningDate: Date)
    var
        Automations: Codeunit Automations;
    begin
        If RunningDate <> 0D then begin
            Automations.ProcessAutomationsInterest(RunningDate);
        end;
    end;

    procedure ProcessAutomationsSTO(var RunningDate: Date)
    var
        Automations: Codeunit Automations;
    begin
        If RunningDate <> 0D then begin
            Automations.ProcessAutomationsSTO(RunningDate);
        end;
    end;

    procedure ValidateAccountDetails(VAR AccountNumber: Code[20]; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text)
    begin
        ResponseMessage := '';
        /*
        IF Vendor.GET(AccountNumber) THEN BEGIN
            AccountTypes.RESET;
            AccountTypes.GET(Vendor."Account Type");
            IF AccountTypes.Type <> AccountTypes.Type::Loan THEN BEGIN
                Vendor.Name := AccountTypes.Description;
            END;
            IF AccountTypes.Type = AccountTypes.Type::Loan THEN BEGIN
                LoanProductTypes.RESET;
                LoanProductTypes.SETRANGE(Code, Vendor."Vendor Posting Group");
                IF LoanProductTypes.FINDSET THEN BEGIN
                    Vendor.Name := LoanProductTypes.Description;
                END;
                //Vendor.Name:=AccountTypes.Description;
            END;
            Member.GET(Vendor."Member No.");
            //Include Fetching of Member Images
            
            Member.CALCFIELDS(Picture);
                  TempFile.CREATETEMPFILE;
                  Filename := TempFile.NAME;
                  TempFile.CLOSE;
                  Member.Picture.CREATEINSTREAM(Istream);
                  MemoryStream := MemoryStream.MemoryStream();
                  COPYSTREAM(MemoryStream, Istream);
                  bytes := MemoryStream.GetBuffer();
                  //convert.ToBase64String(bytes); //This is the image text

                  //
                  imagetext7 := convert.ToBase64String(bytes);
        

            //===new code==================================================
            Filename := 'C:\TempImage\' + Member."No." + '.png';
            //ERROR('%1..',Member.Image.EXPORTFILE(Filename));

            //MESSAGE(Filename);
            IF Filename <> '' THEN BEGIN
              IF Member.Image.EXPORTFILE(Filename) THEN BEGIN
                    MESSAGE('Exported Successfully');
                    fileexported := TRUE;
                    IF FilenameDT.OPEN(Filename) THEN BEGIN
                        FilenameDT.CREATEINSTREAM(imageinstream);
                        MemoryStream := MemoryStream.MemoryStream();
                        COPYSTREAM(MemoryStream, imageinstream);
                        bytes := MemoryStream.GetBuffer();
                        Image6txt2.ADDTEXT(convert.ToBase64String(bytes));
                        FilenameDT.CLOSE;
                        Image6txt2.GETSUBTEXT(imagetext7, 1); //MESSAGE('Good...');
                    END;
                END
                ELSE BEGIN
                    //FilenameDT.OPEN(Filename);
                    //FilenameDT.CLOSE;
                    MESSAGE('++Failed To Export Successfully!');
                END;
               //lg
      END;
      //===end new code==============================================

      //ResponseCode:='000';
      //ResponseMessage:='{"OwnerName":"'+Vendor."Owner Name"+'","AccountName":"'+Vendor.Name+'","MemberImage":"'+imagetext7+'","MobileNo":"'+Member."Phone No."+'","IDNo":"'+Member."National ID"+'"}';
      EXIT;
END;
IF NOT Vendor.GET(AccountNumber) THEN BEGIN
      ResponseCode:='22';
      ResponseMessage:='{"OwnerName":"","AccountName":"","MemberImage":"","MobileNo":"","IDNo":""}';
      ErrorMessage:='Invalid Account!';
      EXIT;
END;
*/
    end;

    procedure MemberRegistration(VAR iDNo: Text; VAR firstName: Text; VAR middleName: Text; VAR branchCode: Text; VAR surname: Text; VAR pinNo: Text; VAR address: Text; VAR gender: Text; VAR occupation: Text; VAR phoneNo: Text; VAR email: Text; VAR passportPhoto: Text; VAR frontID: Text; VAR backID: Text; VAR signature: Text; VAR DateOfBirth: Text; VAR maritalStatus: Text; VAR applicationNo: Text; VAR HudumaNumber: Text; VAR Residence: Text; VAR AlternativeContact: Text; VAR RefererPhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    begin
        /*
    IF iDNo='' THEN BEGIN
            ErrorMessage := 'ID Number Must be input!';
            ResponseCode := '40';
            EXIT;
        END;
    member.RESET;
    member.SETRANGE("National ID",iDNo);
    IF member.FINDSET THEN BEGIN
      ErrorMessage := 'ID No. '+iDNo+' already exists!';
      ResponseCode := '17';
      EXIT;
    END;

    member.RESET;
    member.SETRANGE("Phone No.",phoneNo);
    IF member.FINDSET THEN BEGIN
      ErrorMessage := 'Phone No. '+phoneNo+' already in use!';
      ResponseCode := '46';
      EXIT;
    END;

    MemberApplication.RESET;
    MemberApplication.SETRANGE("Phone No.",phoneNo);
    IF MemberApplication.FINDSET THEN BEGIN
      ErrorMessage := 'Phone No. '+phoneNo+' already in use!';
      ResponseCode := '46';
      EXIT;
    END;

    MemberApplication.RESET;
    MemberApplication.SETRANGE("National ID",iDNo);
    IF MemberApplication.FINDSET THEN BEGIN
      ErrorMessage := 'ID No. '+iDNo+' already exists in Member Applications!';
      ResponseCode := '44';
      EXIT;
    END;

    IF CBSSetup.GET()=FALSE THEN BEGIN
      ErrorMessage := 'FOSA Setup not Setup!';
      ResponseCode := '18';
      EXIT;
    END;

    IF CBSSetup.GET() = TRUE THEN BEGIN
      IF CBSSetup."Member Nos." = '' THEN BEGIN
        ErrorMessage := 'Member Application Numbers not setup in FOSA Setup!';
        ResponseCode := '19';
        EXIT;
      END;
      IF CBSSetup."MA Individual Nos."='' THEN BEGIN
        ErrorMessage := 'Member Numbers not setup in FOSA Setup!';
        ResponseCode := '45';
        EXIT;
      END;
    END;

    IF iDNo = '' THEN BEGIN
      ErrorMessage := 'ID Number Must be input!';
      ResponseCode := '40';
      EXIT;
    END;
    IF firstName +' '+ middleName +' '+ surname = '' THEN BEGIN
      ErrorMessage := 'Member Name must be input!';
      ResponseCode := '41';
      EXIT;
    END;
    IF branchCode = '' THEN BEGIN
      ErrorMessage := 'Branch Code must be input!';
      ResponseCode := '42';
      EXIT;
    END;

    IF STRLEN(phoneNo) <> 12 THEN BEGIN
      ErrorMessage := 'Phone Number Must be Equal to 12 Characters!';
      ResponseCode := '43';
      EXIT;
    END;

    CBSSetup.GET();
    MemberApplication.RESET;
    MemberApplication."No. Series" := branchCode;
    MemberApplication."No.":=NoSeriesMgt.GetNextNo(CBSSetup."Member Nos.",0D,TRUE);
    applicationNo := MemberApplication."No.";
    MemberApplication."First Name":= firstName;
    MemberApplication."Last Name" := middleName;
    MemberApplication.Surname := surname;
    MemberApplication."Full Name" := firstName +' '+ middleName +' '+ surname;
    MemberApplication."National ID" :=iDNo;
    MemberApplication."PIN No.":= pinNo;
    MemberApplication."Branch Code" := branchCode;
    MemberApplication."Physical Address":= address;
    MemberApplication.Occupation := occupation;
    MemberApplication."Phone No." := phoneNo;
    MemberApplication."E-mail" := email;
    MemberApplication.Status := MemberApplication.Status::New;
    MemberApplication."Date of Registration" := TODAY;
    MemberApplication."Member No.":=branchCode+NoSeriesMgt.GetNextNo(CBSSetup."MA Individual Nos.",TODAY,TRUE);
    MemberApplication."Created By" := USERID;
    MemberApplication."Mobile Registration" := TRUE;
    MemberApplication."Date Created" := TODAY;
    MemberApplication."Time Created" := TIME;
    IF passportPhoto <> 'null' THEN BEGIN
      Bytes:=Convert.FromBase64String(passportPhoto);
      MemoryStream:=MemoryStream.MemoryStream(Bytes);
      MemberApplication.Picture.IMPORTSTREAM(MemoryStream, 'PassportPhoto', 'image/jpg');
    END;
    IF frontID <> 'null' THEN BEGIN
    Bytes2:=Convert2.FromBase64String(frontID);
    MemoryStream2:=MemoryStream2.MemoryStream(Bytes2);
    MemberApplication."Front ID".IMPORTSTREAM(MemoryStream2, 'FrontId', 'image/jpg');
    END;
    IF backID <> 'null' THEN BEGIN
    Bytes3:=Convert3.FromBase64String(backID);
    MemoryStream3:=MemoryStream3.MemoryStream(Bytes3);
    MemberApplication."Back ID".IMPORTSTREAM(MemoryStream3, 'BackId', 'image/jpg');
    END;
    IF signature <> 'null' THEN BEGIN
    Bytes4:=Convert4.FromBase64String(signature);
    MemoryStream4:=MemoryStream4.MemoryStream(Bytes4);
    MemberApplication.Signature.IMPORTSTREAM(MemoryStream4, 'Signature', 'image/jpg');
    END;
    Customer2.RESET;
    Customer2.SETRANGE("Phone No.",RefererPhoneNo);
    IF Customer2.FINDSET THEN BEGIN
       MemberApplication."Introducer Member No.":=Customer2."No.";
       MemberApplication."Introducer Member Name":=Customer2."Full Name";
    END;
    CASE gender OF
       '0':
           MemberApplication.Gender := MemberApplication.Gender::Male;
       '1':
           MemberApplication.Gender := MemberApplication.Gender::Female;
      ELSE
           MemberApplication.Gender := MemberApplication.Gender::Other;
    END;

    Ok := MemberApplication.INSERT;

    IF Ok THEN BEGIN
      CLEAR(smstext);
      smstext := STRSUBSTNO(RawSMSText,applicationNo,CBSSetup."Registration Fee");
      CreateSMS(phoneNo,smstext);

      ResponseMessage := 'Successful registration';
      ResponseCode := '00';
    END ELSE BEGIN
        ErrorMessage := 'Failed registration';
        ResponseCode := '01';
    END;
    */
    end;

    procedure verifyApplicationNo(VAR applicationNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text) Success: Integer
    begin
        /*
        MemberApplication.RESET;
        MemberApplication.SETFILTER("No.", applicationNo);
        IF NOT MemberApplication.FINDSET THEN BEGIN
            ErrorMessage := 'Member application does not exist!';
            ResponseCode := '46';
        END ELSE BEGIN
            ResponseMessage := 'Member application exists';
            ResponseCode := '00';
        END;

        EXIT;
        */
    end;

    procedure GeteLoanTypes(VAR MobilePhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text)
    var
        LoanProductTypes: Record "Loan Product Type";
    begin
        LoanProductTypes.RESET;
        LoanProductTypes.SETRANGE("E-Loan", TRUE);
        //LoanProductTypes.SETRANGE(Active,TRUE);
        IF NOT LoanProductTypes.FINDSET THEN BEGIN
            ResponseCode := '09';
            ErrorMessage := 'eLoan Types not setup';
            EXIT;
        END;



        ResponseMessage := '{"eloanTypes" :[';
        LoanProductTypes.RESET;
        LoanProductTypes.SETRANGE("E-Loan", TRUE);
        IF LoanProductTypes.FINDSET THEN BEGIN
            REPEAT

                ResponseMessage +=
                                '{' +
                                    '"LoanCode": "' + LoanProductTypes.Code +
                                    '","LoanName": "' + LoanProductTypes.Description +
                                '"},';

            UNTIL LoanProductTypes.NEXT = 0;
        END;
        ResponseCode := '00';
        ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
        ResponseMessage += ']}';
        EXIT;
    end;

    procedure GetMemberEligibility(VAR PhoneNo: Code[20]; VAR eLoanCode: Code[20]; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text)
    var
        Member: Record Member;
        MemberNo: Code[20];
        MobileBankingMember: Record "Mobile Banking Member";
        RemainingBalance: Decimal;
        LoanProductTypes: Record "Loan Product Type";
        EligibleAmount: Decimal;
        NextDate: Date;
        LoanDefaultRecovery: Record "Loan Defaulter Entry";
        OutsLoanBalances: Decimal;
        LoanApplication: Record "Loan Application";
        AccBalance: array[5] of Decimal;
        GuaranteedAmount: decimal;
        PArrears: Decimal;
        IArrears: Decimal;
        NoOfInstallments: Integer;
        LoanNo: Code[20];
        BosaManagement: Codeunit "BOSA Management";
        TotalBalance: Decimal;
        CustRec: Record Customer;
        Text001: TextConst ENU = 'Loan Application & Disbursement to MPESA';
        Mobilesetup: Record "Mobile Banking Setup";
        GraduationAmount: array[5] of Decimal;
        MemberEligibleAmount: array[5] of Decimal;
        POverpayment: Decimal;
        IOverpayment: Decimal;
    begin
        /*
        Member.RESET;
        Member.SETRANGE("Phone No.", PhoneNo);
        IF Member.FINDSET THEN BEGIN
            MemberNo := Member."No.";

            MobileBankingMember.RESET;
            MobileBankingMember.SETRANGE("Phone No.", Member."Phone No.");
            MobileBankingMember.SETRANGE(Status, MobileBankingMember.Status::Active);
            IF NOT MobileBankingMember.FINDFIRST THEN BEGIN
                ResponseCode := '00';
                RemainingBalance := 0;
                ResponseMessage := FORMAT(RemainingBalance);
                EXIT;
            END;

            MemberNo := Member."No.";
            NextDate := 0D;
            IF LoanProductTypes.GET(eLoanCode) THEN BEGIN
                EligibleAmount := LoanProductTypes."Max. Loan Amount";
            END ELSE BEGIN
                ResponseCode := '00';
                RemainingBalance := 0;
                ResponseMessage := FORMAT(RemainingBalance);
                EXIT;
            END;
            LoanProductTypes.GET(eLoanCode);
            IF Member."Date of Registration" <> 0D THEN
                NextDate := Member."Date of Registration";

            IF NextDate <> 0D THEN BEGIN
                IF CALCDATE(LoanProductTypes."Min. Membership period", NextDate) > TODAY THEN BEGIN
                    ResponseCode := '00';
                    RemainingBalance := 0;
                    ResponseMessage := FORMAT(RemainingBalance);
                    EXIT;
                END;
            END;

            OutsLoanBalances := 0;
            RemainingBalance := 0;

            AccBalance[1] := GetMemberAccBalance(Member."No.", 'DEP');

            LoanApplication.RESET;
            LoanApplication.SETRANGE(Posted, TRUE);
            LoanApplication.SETRANGE("Member No.", MemberNo);
            IF LoanApplication.FINDSET THEN BEGIN
                TotalArrears := 0;
                REPEAT
                    PArrears := 0;
                    IArrears := 0;
                    LedgerFeeArr := 0;
                    PenaltyFeeArr := 0;

                    NoOfInstallments := 0;
                    LoanApplication.CALCFIELDS("Outstanding Balance");
                    IF LoanApplication."Outstanding Balance" > 0 THEN BEGIN

                        IF LoanApplication."Loan Product Type" = eLoanCode THEN BEGIN
                            OutsLoanBalances += LoanApplication."Outstanding Balance";
                        END else begin
                            //CalculateLoanArrears(LoanApplication."No.", 0D, TODAY, PArrears, IArrears, POverpayment, IOverpayment);
                            GlobalManagement.CalculateLoanArrearsAndOverpayment(LoanApplication."No.", 0D, Today, PArrears, IArrears, LedgerFeeArr, PenaltyFeeArr, POverpayment, IOverpayment);
                            TotalArrears += PArrears + IArrears + LedgerFeeArr + PenaltyFeeArr;
                        end;
                    END;
                UNTIL LoanApplication.NEXT = 0;
                IF TotalArrears > 0 THEN BEGIN
                    ResponseCode := '00';
                    RemainingBalance := 0;
                    ResponseMessage := FORMAT(RemainingBalance);
                    EXIT;
                END;
            END;

            IF AccBalance[1] <= 0 THEN BEGIN
                ResponseCode := '00';
                RemainingBalance := 0;
                ResponseMessage := FORMAT(RemainingBalance);
                EXIT;
            END;

            //Available
            CalculateGuaranteedAmount(Member."No.", GuaranteedAmount);

            IF GuaranteedAmount > 0 THEN BEGIN
                AccBalance[3] := AccBalance[1] - GuaranteedAmount;
                IF AccBalance[3] < LoanProductTypes."Max. Loan Amount" THEN BEGIN
                    AccBalance[1] := AccBalance[1] * LoanProductTypes."Loan Deposit Ratio";
                    AccBalance[3] := AccBalance[1] - GuaranteedAmount;
                    AccBalance[2] := AccBalance[3];
                END ELSE
                    AccBalance[2] := AccBalance[3];
                //AccBalance[2] := AccBalance[1] - GuaranteedAmount;
            END ELSE BEGIN
                AccBalance[2] := AccBalance[1];
            END;


            IF AccBalance[2] <= 0 THEN BEGIN
                ResponseCode := '00';
                RemainingBalance := 0;
                ResponseMessage := FORMAT(RemainingBalance);
                EXIT;
            END;
            IF AccBalance[2] < LoanProductTypes."Min. Loan Amount" THEN BEGIN
                ResponseCode := '00';
                RemainingBalance := 0;
                ResponseMessage := FORMAT(RemainingBalance);
                EXIT;
            END ELSE BEGIN
                //    IF AccBalance[2] > LoanProductTypes."Max. Loan Amount" THEN
                //      AccBalance[2] := LoanProductTypes."Max. Loan Amount";
                MemberEligibleAmount[1] := LoanProductTypes."Min. Loan Amount";
                MemberEligibleAmount[2] := LoanProductTypes."Max. Loan Amount";
                IF LoanProductTypes."Graduation Based On" = LoanProductTypes."Graduation Based On"::Deposits THEN BEGIN

                    GraduationAmount[1] := AccBalance[2];
                    IF (LoanProductTypes."Graduation Factor" > 0) AND (LoanProductTypes."Graduation Qualifying Amount" > 0) THEN BEGIN
                        GraduationAmount[2] := GraduationAmount[1] * (LoanProductTypes."Graduation Factor" / 100);
                        GraduationAmount[3] := GraduationAmount[2] * (LoanProductTypes."Graduation Qualifying Amount" / 100);
                        IF GraduationAmount[3] < MemberEligibleAmount[1] THEN BEGIN
                            ResponseCode := '00';
                            RemainingBalance := 0;
                            ResponseMessage := FORMAT(RemainingBalance);
                            EXIT;
                        END ELSE BEGIN
                            IF GraduationAmount[3] > MemberEligibleAmount[2] THEN
                                GraduationAmount[3] := MemberEligibleAmount[2];
                            ResponseCode := '00';
                            RemainingBalance := ROUND(GraduationAmount[3], 0.01, '>');
                            ResponseMessage := FORMAT(RemainingBalance);
                            EXIT;
                        END;
                    END;
                END;
                IF AccBalance[2] > LoanProductTypes."Max. Loan Amount" THEN
                    EligibleAmount := LoanProductTypes."Max. Loan Amount"
                ELSE
                    EligibleAmount := AccBalance[2];

                ResponseCode := '00';
                RemainingBalance := ROUND(EligibleAmount, 0.01, '>');
                ResponseMessage := FORMAT(RemainingBalance);
                EXIT;
            END;
            //To
        END ELSE BEGIN
            ResponseCode := '08';
            ErrorMessage := 'Member with phone no ' + PhoneNo + ' not found';
            EXIT;
        END;
*/
    end;

    procedure ApplyLoan(VAR requestid: Text; VAR PhoneNo: Code[20]; VAR eLoanCode: Code[20]; VAR Amount: Decimal; VAR Installments: Decimal; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text)
    var
        MemberNo: code[25];
        LoanProductTypes: Record "Loan Product Type";
        NextDate: Date;
        BankAccount: Record "Bank Account";
        Member: Record Member;
        LoanBalance: Decimal;
        NoOfLoans: Decimal;
        AccBalance: array[5] of decimal;
        PostDesc: Text;
        MobileBankingEntries: Record "Mobile Banking Ledger Entry";
        LoanApplication: Record "Loan Application";
        PArrears: Decimal;
        IArrears: Decimal;
        NoOfInstallments: Integer;
        LoanNo: Code[20];
        BosaManagement: Codeunit "BOSA Management";
        TotalBalance: Decimal;
        CustRec: Record Customer;
        MobileBankingMember: Record "Mobile Banking Member";
        GuaranteedAmount: Decimal;
        Text001: TextConst ENU = 'Loan Application & Disbursement to MPESA';
        Mobilesetup: Record "Mobile Banking Setup";
        GraduationAmount: array[5] of Decimal;

    begin
        /*
        TotalBalance := 0;
        Mobilesetup.Get();
        Member.RESET;
        Member.SETRANGE("Phone No.", PhoneNo);
        IF NOT Member.FINDSET THEN BEGIN
            ResponseCode := '08';
            ErrorMessage := 'Member with phone no ' + PhoneNo + ' not found';
            EXIT;
        END ELSE BEGIN
            MemberNo := Member."No.";
            MobileBankingMember.RESET;
            MobileBankingMember.SETRANGE("Phone No.", Member."Phone No.");
            MobileBankingMember.SETRANGE(Status, MobileBankingMember.Status::Active);
            IF NOT MobileBankingMember.FINDFIRST THEN BEGIN
                ErrorMessage := 'Provided Phone: ' + PhoneNo + ' is not registered for mobile banking';
                ResponseCode := '10';
                EXIT;
            END;
            LoanProductTypes.RESET;
            LoanProductTypes.SETRANGE(Code, eLoanCode);
            IF NOT LoanProductTypes.FINDSET THEN BEGIN
                ResponseCode := '08';
                ErrorMessage := 'Loan Product ' + eLoanCode + ' not found';
                EXIT;
            END;
            IF Member."Date of Registration" <> 0D THEN
                NextDate := Member."Date of Registration";

            LoanProductTypes.GET(eLoanCode);
            IF NextDate <> 0D THEN BEGIN
                IF CALCDATE(LoanProductTypes."Min. Membership period", NextDate) > TODAY THEN BEGIN
                    ResponseCode := '52';
                    ErrorMessage := 'You do not qualify for this Loan.';
                    EXIT;
                END;
            END;
            LoanBalance := 0;
            NoOfLoans := 0;
            CustRec.RESET;
            CustRec.SETRANGE("Member No.", Member."No.");
            CustRec.SETRANGE("Customer Posting Group", LoanProductTypes.Code);
            CustRec.SETRANGE(Status, CustRec.Status::Active);
            IF CustRec.FINDSET THEN BEGIN
                REPEAT
                    CustRec.CALCFIELDS(Balance);
                    LoanBalance += CustRec.Balance;
                    IF CustRec.Balance > 0 THEN
                        NoOfLoans += 1;
                UNTIL CustRec.NEXT = 0;
            END;
            IF (LoanProductTypes."Allow Multiple Loans" = false) AND (NoOfLoans > 1) THEN BEGIN
                IF NoOfLoans >= LoanProductTypes."No. of Loans at a Time" then BEGIN
                    ResponseCode := '21';
                    ErrorMessage := 'You can only have ' + FORMAT(LoanProductTypes."No. of Loans at a Time") + ' Active loan(s) at a time';
                    EXIT;
                END;
            END;
            IF Amount > LoanProductTypes."Max. Loan Amount" THEN BEGIN
                ResponseCode := '55';
                ErrorMessage := 'You have Applied More than Max Required';
                EXIT;
            END;
            IF Amount < LoanProductTypes."Min. Loan Amount" THEN BEGIN
                ResponseCode := '54';
                ErrorMessage := 'You have Applied Less than Min Required';
                EXIT;
            END;
            IF Amount > LoanProductTypes."Max. Loan Amount" THEN BEGIN
                ResponseCode := '55';
                ErrorMessage := 'You have Applied More than Max Required';
                EXIT;
            END;
            IF Amount < LoanProductTypes."Min. Loan Amount" THEN BEGIN
                ResponseCode := '54';
                ErrorMessage := 'You have Applied Less than Min Required';
                EXIT;
            END;
            AccBalance[1] := 0;
            AccBalance[2] := 0;

            LoanApplication.RESET;
            LoanApplication.SETRANGE(Posted, TRUE);
            LoanApplication.SETRANGE("Member No.", MemberNo);
            IF LoanApplication.FINDSET THEN BEGIN
                REPEAT
                    PArrears := 0;
                    IArrears := 0;
                    LedgerFeeArr := 0;
                    PenaltyFeeArr := 0;
                    NoOfInstallments := 0;
                    TotalArrears := 0;
                    LoanApplication.CALCFIELDS("Outstanding Balance");
                    IF LoanApplication."Outstanding Balance" > 0 THEN BEGIN
                        //CalculateLoanArrears(LoanApplication."No.", 0D, TODAY, PArrears, IArrears, POverpayment, IOverpayment);
                        GlobalManagement.CalculateLoanArrearsAndOverpayment(LoanApplication."No.", 0D, Today, PArrears, IArrears, LedgerFeeArr, PenaltyFeeArr, POverpayment, IOverpayment);
                        TotalArrears := PArrears + IArrears + LedgerFeeArr + PenaltyFeeArr;
                        IF TotalArrears > 0 THEN BEGIN
                            ResponseCode := '23';
                            ErrorMessage := 'Your ' + LoanApplication.Description + ' loan is in default. Please clear Ksh. ' + FORMAT(TotalArrears) + ' to qualify.';
                            EXIT;
                        END;
                    END;
                UNTIL LoanApplication.NEXT = 0;
            END;
            IF LoanProductTypes."Based on Deposits" THEN BEGIN
                AccBalance[1] := GetMemberAccBalance(Member."No.", 'DEP');
                //AccBalance[1] += GetMemberAccBalance(Member."No.", 'SAV');
                IF AccBalance[1] < LoanProductTypes."Minimum Deposit Amount" THEN BEGIN
                    ResponseCode := '24';
                    ErrorMessage := 'You have not reached the minimum required deposits';
                    EXIT;
                END;
                //Available
                CalculateGuaranteedAmount(Member."No.", GuaranteedAmount);
                IF GuaranteedAmount > 0 THEN BEGIN
                    AccBalance[3] := AccBalance[1] - GuaranteedAmount;
                    IF AccBalance[3] < LoanProductTypes."Max. Loan Amount" THEN BEGIN
                        AccBalance[1] *= LoanProductTypes."Loan Deposit Ratio";
                        AccBalance[3] := AccBalance[1] - GuaranteedAmount;
                        AccBalance[2] := AccBalance[3];
                    END ELSE
                        AccBalance[2] := AccBalance[3];
                END ELSE BEGIN
                    AccBalance[2] := AccBalance[1];
                END;

                IF AccBalance[2] <= 0 THEN BEGIN
                    ResponseCode := '39';
                    ErrorMessage := 'You do not have adequate Available Deposits';
                    EXIT;
                END;

                //IF LoanProductTypes."Loan Deposit Ratio" > 1 THEN
                //AccBalance[2] /= LoanProductTypes."Loan Deposit Ratio";

                //    IF LoanProductTypes."Loan Deposit Ratio" > 0 THEN
                //      AccBalance[2] := AccBalance[1] * LoanProductTypes."Loan Deposit Ratio";

                IF Amount > AccBalance[2] THEN BEGIN
                    ResponseCode := '39';
                    ErrorMessage := 'You have Applied more than Available Deposits';
                    EXIT;
                END;

                IF LoanBalance > 0 THEN BEGIN
                    IF LoanBalance > AccBalance[2] THEN BEGIN
                        ResponseCode := '39';
                        ErrorMessage := 'You have Applied more than Available Deposits';
                        EXIT;
                    END;
                    IF LoanBalance > (AccBalance[2] + Amount) THEN BEGIN
                        ResponseCode := '39';
                        ErrorMessage := 'You have Applied more than Available Deposits';
                        EXIT;
                    END;
                END;
            end;
            IF LoanProductTypes."Graduation Based On" = LoanProductTypes."Graduation Based On"::Deposits THEN BEGIN
                GraduationAmount[1] += AccBalance[2];
                IF (LoanProductTypes."Graduation Qualifying Amount" <> 0) AND (LoanProductTypes."Graduation Factor" <> 0) THEN BEGIN
                    IF GraduationAmount[1] > 0 THEN BEGIN
                        GraduationAmount[2] := GraduationAmount[1] * (LoanProductTypes."Graduation Factor" / 100);
                        GraduationAmount[3] := GraduationAmount[2] * (LoanProductTypes."Graduation Qualifying Amount" / 100);
                        IF GraduationAmount[3] < Amount THEN BEGIN
                            ResponseCode := '52';
                            ErrorMessage := 'You do not qualify for this Loan.';
                            EXIT;
                        END ELSE BEGIN

                        END;
                    END ELSE BEGIN
                        ResponseCode := '52';
                        ErrorMessage := 'You do not qualify for this Loan.';
                        EXIT;
                    END;
                END;
            END;
            TotalBalance := LoanBalance + Amount;
            IF LoanProductTypes."Interest Due Posting Group" = '' THEN BEGIN
                ResponseCode := '50';
                ErrorMessage := 'eLoan code does not have Loan Interest Account setup';
                EXIT;
            END;

            BankAccount.RESET;
            BankAccount.SETRANGE("No.", Mobilesetup."Paybill Bank");
            IF not BankAccount.FINDSET THEN BEGIN
                ResponseCode := '51';
                ErrorMessage := 'No Bank has been setup in CBS as Paybill Bank.';
                EXIT;
            END;

            LoanNo := BOSAManagement.postEloan(requestid, MemberNo, Amount);
            IF LoanNo <> '' THEN BEGIN
                ResponseCode := '00';
                ResponseMessage := '{"Response":"Loan application process completed succesfully", "LoanNo": "' + FORMAT(LoanNo) + '"}';
                CreateMobileBankingEntries(requestid, Text001, PhoneNo, 730, Amount, 0, LoanNo, '', '');
                EXIT;
            END ELSE BEGIN
                ResponseCode := '48';
                ErrorMessage := 'eLoan Account not Created';
                EXIT;
            END;
        end;
        */
    end;

    procedure ReferAFriend(VAR FirstName: Text[50]; VAR LastName: Text[50]; VAR PhoneNo: Text[12]; VAR Gender: Text; VAR Location: Text[50]; VAR IntroducerPhone: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text)
    begin
        /*
        IF (FirstName = '') OR (LastName = '') OR (PhoneNo = '') THEN BEGIN
            ResponseCode := '01';
            ErrorMessage := 'Important details missing';
            EXIT;
        END;
        IF PhoneNo = IntroducerPhone THEN BEGIN
            ResponseCode := '01';
            ErrorMessage := 'The phone numbers cannot be same';
            EXIT;
        END;
        CheckPhoneNo[1] := PhoneNo;
        IF COPYSTR(PhoneNo, 1) = '0' THEN BEGIN
            IF COPYSTR(IntroducerPhone, 1, 3) = '254' THEN
                CheckPhoneNo[2] := '0' + COPYSTR(IntroducerPhone, 4, STRLEN(IntroducerPhone));
        END ELSE
            IF COPYSTR(PhoneNo, 1, 3) = '254' THEN BEGIN
                IF COPYSTR(IntroducerPhone, 1, 1) = '0' THEN
                    CheckPhoneNo[2] := '254' + COPYSTR(IntroducerPhone, 2, STRLEN(IntroducerPhone));
            END;

        IF CheckPhoneNo[1] = CheckPhoneNo[2] THEN BEGIN
            ResponseCode := '01';
            ErrorMessage := 'Referred member and introducer phone are same';
            EXIT;
        END;

        IF COPYSTR(PhoneNo, 1) = '0' THEN BEGIN
            CheckPhoneNo[2] := '254' + COPYSTR(PhoneNo, 4, STRLEN(IntroducerPhone));
        END ELSE
            IF COPYSTR(PhoneNo, 1, 3) = '254' THEN BEGIN
                CheckPhoneNo[2] := '0' + COPYSTR(PhoneNo, 4, STRLEN(IntroducerPhone));
            END;

        ReferredMember.RESET;
        ReferredMember.SETFILTER("Phone No.", '%1|%2', CheckPhoneNo[1], CheckPhoneNo[2]); //ERROR(ReferredMember.GETFILTERS);
        IF ReferredMember.FINDFIRST THEN BEGIN
            ResponseCode := '01';
            ErrorMessage := 'Referred member already referred';
            EXIT;
        END;



        Member.RESET;
        Member.SETRANGE("Phone No.", PhoneNo);
        IF Member.FINDSET THEN BEGIN
            ResponseCode := '01';
            ErrorMessage := 'Referred member already registered';
            EXIT;
        END;

        Member.RESET;
        Member.SETRANGE("Phone No.", IntroducerPhone);
        IF Member.FINDSET THEN BEGIN
            smstext := STRSUBSTNO('Dear ' + FirstName + ' ' + LastName + ', ' + Text018, Member."Full Name");
            //SMSJsonBD2.SendText(PhoneNo,smstext);
            SMSSent := CreateSMS(PhoneNo, smstext);
            EntryNo := 0;
            ReferredMember2.RESET;
            ReferredMember2.SETFILTER("Entry No.", '<>%1', 0);
            IF ReferredMember2.FINDLAST THEN
                EntryNo := ReferredMember2."Entry No.";
            ReferredMember.INIT;
            ReferredMember."Entry No." := EntryNo + 1;
            ReferredMember."First Name" := FirstName;
            ReferredMember."Last Name" := LastName;
            ReferredMember."Phone No." := PhoneNo;
            ReferredMember.Location := Location;
            IF Gender = 'F' THEN
                ReferredMember.Gender := ReferredMember.Gender::Female;
            ReferredMember."Referred By Phone No" := IntroducerPhone;
            ReferredMember."Introducer Name" := Member."Full Name";
            ReferredMember."Introducer No." := Member."No.";
            ReferredMember."Referral date" := TODAY;
            ReferredMember."SMS Text" := smstext;
            ReferredMember."SMS Created" := TRUE;
            ReferredMember.INSERT;
        END ELSE BEGIN
            ResponseCode := '01';
            ErrorMessage := 'Introducer not found';
            EXIT;
        END;
        ResponseCode := '00';
        ResponseMessage := 'Refer a Friend was Successful';
        EXIT;
        */
    End;

    procedure GetBranchCodes(VAR MobilePhoneNo: Text; VAR ResponseCode: Text; VAR ResponseMessage: Text; VAR ErrorMessage: Text)
    begin
        /*
                CompanyInformation.GET;


                DimensionValue.RESET;
                DimensionValue.SETRANGE("Global Dimension No.", 1);
                DimensionValue.SETRANGE(Blocked, FALSE);
                IF NOT DimensionValue.FINDSET THEN BEGIN
                    ResponseCode := '16';
                    ErrorMessage := 'Branches not setup in the system';
                    EXIT;
                END;



                ResponseMessage := '{"BranchDetails" :[';
                DimensionValue.RESET;
                DimensionValue.SETRANGE("Global Dimension No.", 1);
                IF DimensionValue.FINDSET THEN BEGIN
                    REPEAT

                        ResponseMessage +=
                                        '{' +
                                            '"BranchCode": "' + DimensionValue.Code +
                                            '","BranchName": "' + DimensionValue.Name +
                                        '"},';

                    UNTIL DimensionValue.NEXT = 0;
                END;
                ResponseCode := '00';
                ResponseMessage := COPYSTR(ResponseMessage, 1, STRLEN(ResponseMessage) - 1);
                ResponseMessage += ']}';
                EXIT;


        */
    end;

    procedure verifyGuarantor(VAR MobilePhoneNo: Text; VAR Amount: Text; VAR response: Text[50]; VAR responsemessage: Text[100]) Success: Integer
    begin
        /*
                EVALUATE(CheckAmount, Amount);
                IF CheckAmount <= 0 THEN BEGIN
                    response := '01';
                    responsemessage := 'Member cannot guarantee the amount.';
                    EXIT;
                END;

                Member.RESET;
                Member.SETRANGE("Phone No.", MobilePhoneNo);
                IF NOT Member.FIND('-') THEN BEGIN
                    response := '14';
                    responsemessage := 'Member does not exist';
                    EXIT;
                END;

                IF Member.Status <> Member.Status::Active THEN BEGIN
                    response := '14';
                    responsemessage := 'Member not active';
                    EXIT;
                END;

                Member.RESET;
                Member.SETRANGE("Phone No.", MobilePhoneNo);
                Member.FINDSET;

                //Available
                AccBalance[1] := GetMemberAccBalance(Member."No.", 'SHARES');


                EligibilityReport.CalculateGuaranteedAmount(Member."No.", GuaranteedAmount);
                IF GuaranteedAmount > 0 THEN BEGIN
                    AccBalance[2] := AccBalance[1] - GuaranteedAmount;
                END ELSE BEGIN
                    AccBalance[2] := AccBalance[1];
                END;

                IF AccBalance[2] < CheckAmount THEN BEGIN
                    response := '01';
                    responsemessage := 'Member cannot guarantee the amount.';
                    EXIT;
                END;

                IF AccBalance[2] <= 0 THEN BEGIN
                    response := '01';
                    responsemessage := 'Member cannot guarantee the amount.';
                    EXIT;
                END ELSE BEGIN
                    response := '00';
                    responsemessage := 'Member can guarantee the amount.';
                    EXIT;
                END;


            */
    End;

    procedure addGuarantor(VAR LoanNo: Text; VAR MobilePhoneNo: Text; VAR Amount: Text; VAR response: Text[50]; VAR responsemessage: Text[100]) Success: Integer
    begin
        /*
                Member.RESET;
                Member.SETRANGE("Phone No.", MobilePhoneNo);
                IF NOT Member.FIND('-') THEN BEGIN
                    ResponseCode := '01';
                    response := ResponseCode;
                    responsemessage := 'Member does not exist';
                    EXIT;
                END;

                IF Member.Status <> Member.Status::Active THEN BEGIN
                    ResponseCode := '01';
                    response := ResponseCode;
                    responsemessage := 'Member not active';
                    EXIT;
                END;

                Member.RESET;
                Member.SETRANGE("Phone No.", MobilePhoneNo);
                Member.FINDSET;

                LoanApplication.RESET;
                LoanApplication.SETRANGE("No.", LoanNo);
                IF LoanApplication.FINDFIRST THEN BEGIN
                    LoanGuarantor.RESET;
                    LoanGuarantor.SETRANGE("Loan No.", LoanNo);
                    LoanGuarantor.SETRANGE("Member No.", Member."No.");
                    IF LoanGuarantor.FINDFIRST THEN BEGIN
                        ResponseCode := '01';
                        response := ResponseCode;
                        responsemessage := 'Member already a guarantor for this loan';
                        EXIT;
                    END ELSE BEGIN
                        LastLineNo := 0;
                        LoanGuarantor.RESET;
                        LoanGuarantor.SETRANGE("Loan No.", LoanNo);
                        LoanGuarantor.SETCURRENTKEY("Line No.");
                        LoanGuarantor.SETASCENDING("Line No.", FALSE);
                        IF LoanGuarantor.FINDFIRST THEN BEGIN
                            LastLineNo := LoanGuarantor."Line No." + 1;
                        END;
                        LoanGuarantor2.INIT;
                        LoanGuarantor2."Loan No." := LoanNo;
                        LoanGuarantor2."Line No." := LastLineNo;
                        LoanGuarantor2."Member No." := Member."No.";
                        LoanGuarantor2."Account No." := LoanNo;
                        LoanGuarantor2."Account Name" := LoanApplication.Description;
                        LoanGuarantor2."Member Name" := Member."Full Name";
                        EVALUATE(GuaranteeAmount, Amount);
                        LoanGuarantor2."Amount To Guarantee" := GuaranteeAmount;
                        LoanGuarantor2.INSERT;
                        ResponseCode := '00';
                        response := ResponseCode;
                        responsemessage := 'Guarantor added successfully';
                        EXIT;
                    END;
                END ELSE BEGIN
                    ResponseCode := '01';
                    response := ResponseCode;
                    responsemessage := 'Loan does not exist';
                    EXIT;
                END;

            */
    end;

    var
        SaccoCharges: Decimal;
        SaccoGL: code[100];
        ExciseAmount: Decimal;
        ExciseGL: code[100];
        SettlementAmount: Decimal;
        SettlementGL: code[100];
        ChargeAmount: Decimal;
        BankAccount: Record "Bank Account";
}