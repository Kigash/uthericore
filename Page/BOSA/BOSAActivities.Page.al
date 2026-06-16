page 50348 "BOSA Activities"
{
    PageType = CardPart;
    SourceTable = "BOSA Cue";

    layout
    {
        area(content)
        {
            cuegroup(LoanApplicationWideLayout)
            {

                Caption = 'Summary';
                CuegroupLayout = Wide;
                // field("Total Requested Amount"; Rec."Total Requested Amount")
                // {
                //     Caption = 'Total Requested Amount';
                //     DrillDownPageId = "Posted Loan List";
                //     ApplicationArea = All;
                // }
                field("Total Disbursed Amount"; Rec."Total Disbursed Amount")
                {
                    Caption = 'Total Disbursed Amount';
                    Image = Calculator;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
                field(TotalOLB; TotalOLB)

                {
                    Caption = 'Total Oustanding Loan Balance';
                    ApplicationArea = All;
                    Image = Cash;
                    DrillDownPageId = "Loan Applications List-Posted";

                }
                field(ActiveLoansArrears; ActiveLoansArrears)
                {
                    Caption = 'Active Loans Total Arrears';
                    ApplicationArea = All;
                    Image = Receipt;
                    DrillDownPageId = "Loan Applications List-Posted";
                }
                field(ExpiredLoansArrears; ExpiredLoansArrears)
                {
                    Caption = 'Expired Loans Total Arrears';
                    ApplicationArea = All;
                    Image = Receipt;
                    DrillDownPageId = "Loan Applications List-Posted";
                }
                field(TotalArrears; TotalArrears)
                {
                    Caption = 'Total Arrears';
                    ApplicationArea = All;
                    Image = Receipt;
                    DrillDownPageId = "Loan Applications List-Posted";
                }
                field(TotalPAR; TotalPAR)
                {
                    Caption = 'Total PAR';
                    Image = Chart;
                    ApplicationArea = All;
                    DrillDownPageId = "Loan Applications List-Posted";

                }

            }
            cuegroup(LoanApplicationCueContainer)
            {
                Caption = 'Loan Application';
                //CuegroupLayout = Wide;
                field("LoanApplication-New"; Rec."LoanApplication-New")
                {
                    Caption = 'New';
                    DrillDownPageId = "Loan Application List-New";
                    ApplicationArea = All;
                }
                field("LoanApplication-Pending"; Rec."LoanApplication-Pending")
                {
                    Caption = 'Pending Appraisal';
                    DrillDownPageId = "Loan Appl. List-Pending Apprsl";
                    ApplicationArea = All;
                }
                field("LoanApplication-Approved"; Rec."LoanApplication-Approved")
                {
                    Caption = 'Pending Disbursal';
                    DrillDownPageId = "Loan Appl. List-Pending Dbsl";
                    ApplicationArea = All;
                }
                field("LoanApplication-Posted"; Rec."LoanApplication-Posted")
                {
                    Caption = 'Posted Loans';
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }

            }
            cuegroup(StandingOrderCueContainer)
            {
                Caption = 'Standing Order';
                //CuegroupLayout = Wide;
                field("StandingOrder-New"; Rec."StandingOrder-New")
                {
                    Caption = 'New';
                    DrillDownPageId = "Standing Order List-New";
                    ApplicationArea = All;
                }
                field("StandingOrder-Pending"; Rec."StandingOrder-Pending")
                {
                    Caption = 'Pending Approval';
                    DrillDownPageId = "Standing Order List-Pending";
                    ApplicationArea = All;
                }
                field("StandingOrder-Running"; Rec."StandingOrder-Running")
                {
                    Caption = 'Running';
                    DrillDownPageId = "Standing Order List-Running";
                    ApplicationArea = All;
                }
                field("StandingOrder-Approved"; Rec."StandingOrder-Approved")
                {
                    Caption = 'Stopped';
                    DrillDownPageId = "Standing Order List-Approved";
                    ApplicationArea = All;
                }

            }


            cuegroup(LoanApplicationActionContainer)
            {
                Caption = 'Loan Application';

                actions
                {

                    action("New Loan Application")
                    {
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "Loan Application Card";
                        Image = TileNew;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
            cuegroup(StandingOrderActionContainer)
            {
                Caption = 'Standing Order';

                actions
                {

                    action("New Standing Order")
                    {
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "Standing Order Card";
                        Image = TileNew;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
            cuegroup(FundTransferActionContainer)
            {
                Caption = 'Fund Transfer';

                actions
                {

                    action("New Funs Transfer")
                    {
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "Fund Transfer";
                        Image = TileNew;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
            cuegroup(GuarantorSubstitutionActionContainer)
            {
                Caption = 'Guarantor Substitution';

                actions
                {

                    action("New Guarantor Substitution")
                    {
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "Guarantor Substitution";
                        Image = TileNew;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
            cuegroup(LoanReschedulingActionContainer)
            {
                Caption = 'Loan Rescheduling';

                actions
                {

                    action("New Loan Rescheduling")
                    {
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "Loan Rescheduling";
                        Image = TileNew;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin

                        end;
                    }
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.Reset();
        if not Rec.Get then begin
            Rec.Init();
            Rec.Insert();
        end;
        CalculateLoanSummary();
    end;

    local procedure CalculateLoanSummary()
    var
        LoanClassificationEntry: Record "Loan Classification Entry";
        LoanClassificationEntry2: Record "Loan Classification Entry";
        Loan: Record "Loan Application";
        GlobalM: Codeunit "Global Management";
        ArrearsAmount: array[4] of Decimal;
        OverpaymentAmount: array[4] of Decimal;
        BosaM: Codeunit "BOSA Management";
        NoofDaysInArrears: Integer;
        NoofInstallmentInArrears: Integer;
        ClassificationCode: Code[100];
        ClassificationDesc: Text;
        ProvisioningPercent: Decimal;
        ExpBal: Decimal;
        LoanSched: Record "Loan Repayment Schedule";
        LoanArrears: Decimal;
    begin
        TotalArrears := 0;
        TotalPAR := 0;
        TotalOLB := 0;
        ArrearsAmount[1] := 0;
        ArrearsAmount[2] := 0;
        ArrearsAmount[3] := 0;
        ArrearsAmount[4] := 0;
        OverpaymentAmount[1] := 0;
        OverpaymentAmount[2] := 0;
        NoofDaysInArrears := 0;
        NoofInstallmentInArrears := 0;

        ClassificationDesc := '';

        Loan.Reset();
        Loan.SetRange(Posted, true);
        if Loan.FindSet() then begin
            repeat
                ExpBal := 0;
                LoanArrears := 0;
                Loan.CalcFields("Outstanding Balance");
                if Loan."Outstanding Balance" > 0 then begin
                    GlobalM.CalculateLoanArrearsAndOverpayment(Loan."No.", 0D, Today, ArrearsAmount[1], ArrearsAmount[2], ArrearsAmount[3], ArrearsAmount[4], OverpaymentAmount[1], OverpaymentAmount[2]);
                    If Loan."Date of Completion" > Today then begin
                        LoanSched.Reset();
                        LoanSched.SetRange("Loan No.", Loan."No.");
                        LoanSched.SetFilter("Repayment Date", '<=%1', Today);
                        if LoanSched.FindLast() then begin
                            ExpBal := LoanSched."Loan Amount" + LoanSched."Interest Installment";
                        end else begin
                            ExpBal := Loan."Approved Amount";
                        end;
                    end;
                    LoanArrears := ArrearsAmount[1] + ArrearsAmount[2];
                    If LoanArrears > 0 then
                        LoanArrears := LoanArrears
                    else
                        LoanArrears := 0;
                    BosaM.CalculateDaysAndInstallmentsInArrearsDefaulter(Loan."No.", LoanArrears, NoofDaysInArrears, NoofInstallmentInArrears, Today);
                    BosaM.GetClassificationClassDetails(NoofDaysInArrears, ClassificationCode, ClassificationDesc, ProvisioningPercent);
                    TotalArrears += LoanArrears;
                    if (ClassificationDesc = 'WATCH') or (ClassificationDesc = 'DOUBTFUL') or (ClassificationDesc = 'SUBSTANDARD') or (ClassificationDesc = 'LOSS') then
                        TotalPAR += Loan."Outstanding Balance";
                    TotalOLB += Loan."Outstanding Balance";
                    if Loan."Date of Completion" <= Today then
                        ExpiredLoansArrears += LoanArrears
                    else
                        ActiveLoansArrears += LoanArrears;
                end;
            until Loan.Next = 0;
        end;
    end;

    var
        TotalArrears: Decimal;
        TotalPAR: Decimal;
        TotalOLB: Decimal;
        ExpiredLoansArrears: Decimal;
        ActiveLoansArrears: Decimal;

}