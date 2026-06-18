page 50041 MemberStatisticsFactBox
{
    Caption = 'Member Statistics FactBox';
    PageType = CardPart;
    SourceTable = Member;

    layout
    {
        area(content)
        {
            field(Deposit; Deposit)
            {
                Caption = 'Unwithdrawable Member Deposits';
                ApplicationArea = All;
            }
            field(Shares; Shares)
            {
                Caption = 'Share Capital';
                ApplicationArea = All;
            }

            field(FieldColl; FieldColl)
            {
                Caption = 'Withdrawable Deposits Held';
                ApplicationArea = All;
            }
            field(OfficeColl; OfficeColl)
            {
                Caption = 'Withdrawable Deposits Available';
                ApplicationArea = All;
            }
            field(Ordinary; Ordinary)
            {
                Caption = 'Total Withdrawable Deposits';
                ApplicationArea = All;
            }
            field("Loan Outstanding Interest"; OutInt)
            {
                ApplicationArea = All;
            }
            field("Loan Outstanding Principal"; OutPrinc)
            {
                ApplicationArea = All;
            }
            field("Loan Total Outstanding Balance"; OutBal)
            {
                ApplicationArea = All;
            }
            field("Total Arrears"; TotalArrears)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Deposit := 0;
        Ordinary := 0;
        Shares := 0;
        GDeposit := 0;
        GOrdinary := 0;
        GShares := 0;
        FieldColl := 0;
        OfficeColl := 0;
        Estate := 0;
        Xmas := 0;
        OutBal := 0;
        OutInt := 0;
        OutPrinc := 0;
        OutLedg := 0;
        OutPen := 0;
        TotalArrears := 0;

        AccType.Reset();
        AccType.SetRange(AccType.Type, AccType.Type::"Member Deposit");
        if AccType.FindFirst() then begin
            Vend.Reset();
            Vend.SetRange("Member No.", Rec."No.");
            Vend.SetRange("Account Type", AccType.Code);
            if Vend.FindFirst() then begin
                Vend.CalcFields(Balance);
                Deposit := Vend.Balance;
            end;
        end;

        AccType.Reset();
        AccType.SetRange(AccType.Type, AccType.Type::"Share Capital");
        if AccType.FindFirst() then begin
            Vend.Reset();
            Vend.SetRange("Member No.", Rec."No.");
            Vend.SetRange("Account Type", AccType.Code);
            if Vend.FindFirst() then begin
                Vend.CalcFields(Balance);
                Shares := Vend.Balance;
            end;
        end;

        AccType.Reset();
        AccType.SetRange(AccType.Type, AccType.Type::Savings);
        AccType.SetRange(AccType."Sub Type", AccType."Sub Type"::Ordinary);
        if AccType.FindFirst() then begin
            Vend.Reset();
            Vend.SetRange("Member No.", Rec."No.");
            Vend.SetRange("Account Type", AccType.Code);
            if Vend.FindFirst() then begin
                Vend.CalcFields(Balance, "Withheld Sep10th 2024 Balance", "Deposits From Sep10th 2024 Balance");
                Ordinary := Vend.Balance;
                FieldColl := Vend."Withheld Sep10th 2024 Balance";
                OfficeColl := Vend."Deposits From Sep10th 2024 Balance";
            end;
        end;

        Tsetup.Get();


        Cust.Reset();
        Cust.SetRange("Member No.", Rec."No.");
        if Cust.FindSet() then begin
            repeat
                Cust.CalcFields(Balance);
                if Cust.Balance > 0 then begin
                    OutBal += Cust.Balance;

                    Dcust.Reset();
                    Dcust.SetRange("Customer No.", Cust."No.");
                    if Dcust.FindSet() then begin
                        repeat
                            if (Dcust."Transaction Type Code" = Tsetup."New Loan") or (Dcust."Transaction Type Code" = Tsetup."Principal Paid") then
                                OutPrinc += Dcust.Amount;
                            if (Dcust."Transaction Type Code" = Tsetup."Interest Due") or (Dcust."Transaction Type Code" = Tsetup."Interest Paid") then
                                OutInt += Dcust.Amount;
                            if (Dcust."Transaction Type Code" = Tsetup."Ledger Fee Due") or (Dcust."Transaction Type Code" = Tsetup."Ledger Fee Paid") then
                                OutLedg += Dcust.Amount;
                            if (Dcust."Transaction Type Code" = Tsetup."Penalty Due") or (Dcust."Transaction Type Code" = Tsetup."Penalty Paid") then
                                OutPen += Dcust.Amount;
                        until Dcust.Next = 0;
                    end;
                    GlobalM.CalculateLoanArrearsAndOverpayment(Cust."No.", 0D, Today, ArrearsAmount[1], ArrearsAmount[2], ArrearsAmount[3], ArrearsAmount[4], OverPAmount[1], OverPAmount[2]);
                    TotalArrears += ArrearsAmount[1] + ArrearsAmount[2] + ArrearsAmount[3] + ArrearsAmount[4];
                end;
            until Cust.Next = 0;
        end;

    end;

    var
        Deposit: Decimal;
        GDeposit: Decimal;
        GShares: Decimal;
        GOrdinary: Decimal;
        TotalArrears: Decimal;
        GlobalM: Codeunit "Global Management";
        ArrearsAmount: array[5] of Decimal;
        OverPAmount: array[5] of Decimal;
        Shares: Decimal;
        Ordinary: Decimal;
        Xmas: Decimal;
        Estate: Decimal;
        FieldColl: Decimal;
        OfficeColl: Decimal;
        AccType: Record "Account Type";
        Vend: Record Vendor;
        Tsetup: Record "Transaction Type Code Setup";
        OutBal: Decimal;
        OutPrinc: Decimal;
        OutInt: Decimal;
        OutLedg: Decimal;
        OutPen: Decimal;
        Cust: Record Customer;
        Dcust: Record "Detailed Cust. Ledg. Entry";
}
