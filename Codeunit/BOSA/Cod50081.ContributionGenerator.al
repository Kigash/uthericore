codeunit 50081 "Contribution Generator"
{
    procedure GenerateData(StartDate: Date; EndDate: Date)
    var
        Contrib: Record "Member Contribution";
        Vend: Record Vendor;
        TelH: Record "Teller Transaction Header";
        TelL: Record "Teller Transaction Line";
        Mem: Record Member;
        AccType: Record "Account Type";
        Window: Dialog;
        Counter, TotalMembers : Integer;
        FromDate: Date;
        Savings, Deposit, Shares, ServiceCharge : Decimal;
    begin
        if StartDate = 0D then
            FromDate := DMY2DATE(1, 1, 1900)
        else
            FromDate := StartDate;

        if Contrib.FindSet() then
            repeat
                Contrib.Delete();
            until Contrib.Next() = 0;

        Mem.Reset();
        TotalMembers := Mem.Count();
        Counter := 0;
        Window.OPEN('Generating Member Contributions…\\Step: #1/#2\\Current: #3');

        if Mem.FindSet() then
            repeat
                Counter += 1;
                Window.UPDATE(1, Counter);
                Window.UPDATE(2, TotalMembers);
                Window.UPDATE(3, 'Member: ' + Mem."No.");

                GetMemberBalances(Mem."No.", Savings, Deposit, Shares);

                ServiceCharge := CalculateServiceCharge(Mem."No.", FromDate, EndDate, TelH, TelL);

                if Savings <> 0 then
                    InsertContrib(Mem."No.", 'SAV', '', FromDate, EndDate, Savings);
                if Deposit <> 0 then
                    InsertContrib(Mem."No.", 'DEP', '', FromDate, EndDate, Deposit);
                if Shares <> 0 then
                    InsertContrib(Mem."No.", 'SHR', '', FromDate, EndDate, Shares);
                if ServiceCharge <> 0 then
                    InsertContrib(Mem."No.", 'SRV', '', FromDate, EndDate, ServiceCharge);

            until Mem.Next() = 0;

        Window.CLOSE();
        Message('Contribution summary successfully generated.');
    end;

    local procedure InsertContrib(MemberNo: Code[20]; Category: Code[20]; AccountNo: Code[20]; StartDate: Date; EndDate: Date; Amount: Decimal)
    var
        Contrib: Record "Member Contribution";
    begin
        if MemberNo = '' then
            exit; // skip if MemberNo not found
        if Category = '' then
            Category := 'UNKNOWN';
        if AccountNo = '' then
            AccountNo := '000';

        Contrib.SetRange("Member No.", MemberNo);
        Contrib.SetRange("Account Category", Category);
        Contrib.SetRange("Account No.", AccountNo);
        Contrib.SetRange("Start Date", StartDate);
        Contrib.SetRange("End Date", EndDate);

        if Contrib.FindFirst() then begin
            Contrib.Amount += Amount;
            Contrib.Modify();
        end else begin
            Contrib.Init();
            Contrib."Member No." := MemberNo;
            Contrib."Account Category" := Category;
            Contrib."Account No." := AccountNo;
            Contrib."Start Date" := StartDate;
            Contrib."End Date" := EndDate;
            Contrib.Amount := Amount;
            Contrib.Insert();
        end;
    end;

    local procedure GetMemberBalances(MemberNo: Code[20]; var Savings: Decimal; var Deposit: Decimal; var Shares: Decimal)
    var
        Vend: Record Vendor;
        AccType: Record "Account Type";
    begin
        Savings := 0;
        Deposit := 0;
        Shares := 0;

        AccType.Reset();
        AccType.SetRange(Type, AccType.Type::"Member Deposit");
        if AccType.FindSet() then
            repeat
                Vend.Reset();
                Vend.SetRange("Member No.", MemberNo);
                Vend.SetRange("Account Type", AccType.Code);
                if Vend.FindFirst() then begin
                    Vend.CalcFields(Balance);
                    Deposit += Vend.Balance;
                end;
            until AccType.Next() = 0;

        AccType.Reset();
        AccType.SetRange(Type, AccType.Type::"Share Capital");
        if AccType.FindSet() then
            repeat
                Vend.Reset();
                Vend.SetRange("Member No.", MemberNo);
                Vend.SetRange("Account Type", AccType.Code);
                if Vend.FindFirst() then begin
                    Vend.CalcFields(Balance);
                    Shares += Vend.Balance;
                end;
            until AccType.Next() = 0;

        AccType.Reset();
        AccType.SetRange(Type, AccType.Type::Savings);
        AccType.SetRange("Sub Type", AccType."Sub Type"::Ordinary);
        if AccType.FindSet() then
            repeat
                Vend.Reset();
                Vend.SetRange("Member No.", MemberNo);
                Vend.SetRange("Account Type", AccType.Code);
                if Vend.FindFirst() then begin
                    Vend.CalcFields(Balance);
                    Savings += Vend.Balance;
                end;
            until AccType.Next() = 0;
    end;

    local procedure CalculateServiceCharge(MemberNo: Code[20]; FromDate: Date; ToDate: Date; TelH: Record "Teller Transaction Header"; TelL: Record "Teller Transaction Line"): Decimal
    var
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;
        TelH.Reset();
        TelH.SetRange(Posted, true);
        TelH.SetRange("Transaction Date", FromDate, ToDate);
        if TelH.FindSet() then
            repeat
                TelL.Reset();
                TelL.SetRange("Transaction No.", TelH."No.");
                TelL.SetRange("Member No.", MemberNo);
                TelL.SetFilter("Account No.", '003');
                if TelL.FindSet() then
                    repeat
                        TotalAmount += Abs(TelL."Line Amount");
                    until TelL.Next() = 0;
            until TelH.Next() = 0;
        exit(TotalAmount);
    end;



}
