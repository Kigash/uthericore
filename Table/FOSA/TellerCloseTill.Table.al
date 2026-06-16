table 50053 "Teller Close Till"
{
    Caption = 'Open/Close Till';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN
                    "No. Series" := '';
            end;
        }
        field(3; Description; Text[50])
        {

        }
        field(4; "Teller User ID"; Text[50])
        {
            Editable = false;
        }

        field(5; "Till Balance"; Decimal)
        {
            Editable = false;
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; "Till No."; Code[20])
        {
            Editable = false;
            TableRelation = "Bank Account";
        }
        field(9; "Till Name"; Text[50])
        {
            Editable = false;
        }
        field(10; "Transaction Date"; Date)
        {
            Editable = false;
        }
        field(11; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(13; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(14; "Action Type"; Option)
        {
            OptionCaption = ' ,Open Till,Close Till';
            OptionMembers = " ","Open Till","Close Till";
        }
        field(20; "Teller Host IP"; Code[20])
        {
            Editable = false;
        }
        field(21; "Teller Host MAC"; Code[20])
        {
            Editable = false;
        }
        field(22; "Teller Host Name"; Code[30])
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var

    begin
        TelleringSetup.GET;
        IF "No." = '' THEN
            "No." := NoSeriesManagement.GetNextNo(TelleringSetup."Teller Close Till Nos.");
        GlobalManagement.GetHostInfo(HostName, HostMac, HostIP);

        "Teller Host IP" := HostIP;
        "Teller Host MAC" := HostMac;
        "Teller Host Name" := HostName;
        "Teller User ID" := UserId;
        "Transaction Date" := Today;
        "Transaction Time" := Time;

        ValidateTeller();
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

    local procedure ValidateTeller()
    var

    begin
        if TellerUserSetup.get(UserId) then begin
            BankAccount.get(TellerUserSetup."Till No.");
            BankAccount.CalcFields(Balance);
            "Till Balance" := BankAccount.Balance;
            "Till No." := TellerUserSetup."Till No.";
            "Till Name" := BankAccount.Name;
        end;
    end;

    var
        TelleringSetup: Record "Tellering Setup";
        HostMac: Code[20];
        HostName: Code[20];
        HostIP: Code[20];
        NoSeriesManagement: Codeunit "No. Series";
        GlobalManagement: Codeunit "Global Management";
        BankAccount: Record "Bank Account";
        TellerUserSetup: Record "Teller User Setup";
        TelleringTreasury: Codeunit "Tellering & Treasury";
        TransactionType: Record "Transaction -Type";
        PopulateCoinageErr: Label 'You must populate the Transaction Coinage section';
        ExceededWithdrawalLimitErr: Label 'You have exceeded the maximum withdrawal amount allowed for this Teller';
        ExceededDepositLimitErr: Label 'You have exceeded the maximum deposit amount allowed for this Teller';
        ExceededTillBalanceErr: Label 'You have exceeded Till balance';
        WithdrawalNotAllowedErr: Label 'Withdrawal service is not allowed for this Teller';
        DepositNotAllowedErr: Label 'Deposit service is not allowed for this Teller';

        TellerNotActivatedErr: Label 'Teller %1 is not active';
        UserNotSetupAsTellerErr: Label 'User %1 has not been setup as a Teller';
        TillExceededMaxLimitMsg: Label 'Till Balance has exceeded the Maximum Allowed Limit,\Do you wish to create a Return to Treasury request?';
        TillBelowMinLimitMsg: Label 'Till Balance has is below the  the Minimum Allowed Limit,\Do you wish to create a Request from Treasury?';
        HeaderAmountNotEqualConfirmMsg: Label '%1 and %2 must be equal';
        TellerTransactionLine: Record "Teller Transaction Line";
        TransactionCoinageSetup: Record "Transaction Coinage Setup";
        TellerMemberStatistic: Record "Teller Member Statistic";

}