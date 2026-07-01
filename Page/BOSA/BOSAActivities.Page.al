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
                    Image = Cash;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
                field(PrincipalArrears; PrincipalArrears)
                {
                    Caption = 'Principal Arrears';
                    Image = Receipt;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
                field(InterestArrears; InterestArrears)
                {
                    Caption = 'Interest Arrears';
                    Image = Receipt;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
                field(PenaltyArrears; PenaltyArrears)
                {
                    Caption = 'Penalty Arrears';
                    Image = Receipt;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
                field(TotalAmountDue; TotalAmountDue)
                {
                    Caption = 'Total Amount Due';
                    Image = Receipt;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
                field(ActiveLoansArrears; ActiveLoansArrears)
                {
                    Caption = 'Active Loans Total Pricipal Arrears';
                    Image = Receipt;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
                field(ExpiredLoansArrears; ExpiredLoansArrears)
                {
                    Caption = 'Expired Loans Total Principal Arrears';
                    Image = Receipt;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
                field(TotalArrears; TotalArrears)
                {
                    Caption = 'Total Principal Arrears';
                    Image = Receipt;
                    Visible = false;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
                field(TotalPAR; TotalPAR)
                {
                    Caption = 'Total PAR';
                    Image = Chart;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                }
                field(PERFORMING; PERFORMING)
                {
                    Caption = 'Performing Loans';
                    Image = Chart;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        LoanRec: Record "Loan Application";
                    begin
                        LoanRec.Reset();
                        LoanRec.SetRange(Posted, true);
                        LoanRec.SetRange(Cleared, false);
                        LoanRec.SetRange(Classification, 'PERFORMING');
                        LoanRec.SetFilter("Outstanding Balance", '>%1', 0);
                        Page.Run(Page::"Loan Applications List-Posted", LoanRec);
                    end;
                }
                field(WATCH; WATCH)
                {
                    Caption = 'Watching Loans';
                    Image = Chart;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        LoanRec: Record "Loan Application";
                    begin
                        LoanRec.Reset();
                        LoanRec.SetRange(Posted, true);
                        LoanRec.SetRange(Cleared, false);
                        LoanRec.SetRange(Classification, 'WATCH');
                        LoanRec.SetFilter("Outstanding Balance", '>%1', 0);
                        Page.Run(Page::"Loan Applications List-Posted", LoanRec);
                    end;
                }
                field(DOUBTFUL; DOUBTFUL)
                {
                    Caption = 'Doubful Loans';
                    Image = Chart;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        LoanRec: Record "Loan Application";
                    begin
                        LoanRec.Reset();
                        LoanRec.SetRange(Posted, true);
                        LoanRec.SetRange(Cleared, false);
                        LoanRec.SetRange(Classification, 'DOUBTFUL');
                        LoanRec.SetFilter("Outstanding Balance", '>%1', 0);
                        Page.Run(Page::"Loan Applications List-Posted", LoanRec);
                    end;
                }
                field(SUBSTANDARD; SUBSTANDARD)
                {
                    Caption = 'Substandard Loans';
                    Image = Chart;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        LoanRec: Record "Loan Application";
                    begin
                        LoanRec.Reset();
                        LoanRec.SetRange(Posted, true);
                        LoanRec.SetRange(Cleared, false);
                        LoanRec.SetRange(Classification, 'SUBSTANDARD');
                        LoanRec.SetFilter("Outstanding Balance", '>%1', 0);
                        Page.Run(Page::"Loan Applications List-Posted", LoanRec);
                    end;
                }
                field(LOSS; LOSS)
                {
                    Caption = 'Loss Loans';
                    Image = Chart;
                    DrillDownPageId = "Loan Applications List-Posted";
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        LoanRec: Record "Loan Application";
                    begin
                        LoanRec.Reset();
                        LoanRec.SetRange(Posted, true);
                        LoanRec.SetRange(Cleared, false);
                        LoanRec.SetRange(Classification, 'LOSS');
                        LoanRec.SetFilter("Outstanding Balance", '>%1', 0);
                        Page.Run(Page::"Loan Applications List-Posted", LoanRec);
                    end;
                }

            }
            cuegroup(LoanApplicationCueContainer)
            {
                Caption = 'Loan Application';

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
        }
    }

    trigger OnOpenPage();
    begin
        Rec.Reset();
        if not Rec.Get() then begin
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
        LoanSched2: Record "Loan Repayment Schedule";
        LoanArrears: Decimal;
        TotalLoanAmount: Decimal;
        TotalPrincipalPaid: Decimal;
        TotalInterestPaid: Decimal;
        TotalPaidAmount: Decimal;
        ExpectedPayment: Decimal;

    begin
        PERFORMING := 0;
        WATCH := 0;
        DOUBTFUL := 0;
        SUBSTANDARD := 0;
        LOSS := 0;

        Loan.Reset();
        Loan.SetRange(Posted, true);
        if Loan.FindSet() then begin
            repeat
                Loan.CalcFields("Outstanding Balance");
                ExpBal := 0;
                LoanArrears := 0;
                ArrearsAmount[1] := 0;
                ArrearsAmount[2] := 0;
                ArrearsAmount[3] := 0;
                ArrearsAmount[4] := 0;
                OverpaymentAmount[1] := 0;
                OverpaymentAmount[2] := 0;
                NoofDaysInArrears := 0;
                NoofInstallmentInArrears := 0;
                ClassificationDesc := '';
                TotalLoanAmount := 0;
                if Loan."Outstanding Balance" > 0 then begin
                    GlobalM.CalculateLoanArrearsAndOverpayment(Loan."No.", 0D, Today, ArrearsAmount[1], ArrearsAmount[2], ArrearsAmount[3], ArrearsAmount[4], OverpaymentAmount[1], OverpaymentAmount[2]);
                    Loan."Principal Arrears" := ArrearsAmount[1];
                    Loan."Interest Arrears" := ArrearsAmount[2];
                    Loan."Ledger Fee Arrears" := ArrearsAmount[3];
                    Loan."Penalty Arrears" := ArrearsAmount[4];
                    Loan."Principal Overpayment" := OverpaymentAmount[1];
                    Loan."Interest Overpayment" := OverpaymentAmount[2];
                    Loan."Total Overpayment" := OverpaymentAmount[1] + OverpaymentAmount[2];
                    If Loan."Date of Completion" > Today then begin
                        LoanSched.Reset();
                        LoanSched.SetRange("Loan No.", Loan."No.");
                        LoanSched.SetFilter("Repayment Date", '<=%1', Today);
                        if LoanSched.FindLast() then begin
                            LoanSched2.Reset();
                            LoanSched2.SetRange("Loan No.", Loan."No.");
                            LoanSched2.SetFilter("Repayment Date", '>%1', Today);
                            if LoanSched2.FindFirst() then begin
                                Loan."Expected Balance" := LoanSched2."Loan Amount" + LoanSched."Interest Installment";
                            end;
                        end else begin
                            Loan."Expected Balance" := Loan."Approved Amount";
                        end;
                    end;
                    ArrearsAmount[4] := ArrearsAmount[1] + ArrearsAmount[2];

                    Loan."Total Arrears" := ArrearsAmount[4];
                    //"Total Arrears" := ArrearsAmount[1] + ArrearsAmount[2] + ArrearsAmount[3] + ArrearsAmount[4];
                    BosaM.CalculateDaysAndInstallmentsInArrearsDefaulter(Loan."No.", (ArrearsAmount[4]), NoofDaysInArrears, NoofInstallmentInArrears, Today);
                    BosaM.GetClassificationClassDetails(NoofDaysInArrears, ClassificationCode, ClassificationDesc, ProvisioningPercent);
                    Loan."Days In Arrears" := NoofDaysInArrears;
                    Loan."Installment In Arrears" := NoofInstallmentInArrears;
                    Loan."Classification" := ClassificationDesc;
                    //Loan.Modify();
                end else begin
                    GlobalM.CalculateLoanArrearsAndOverpayment(Loan."No.", 0D, Today, ArrearsAmount[1], ArrearsAmount[2], ArrearsAmount[3], ArrearsAmount[4], OverpaymentAmount[1], OverpaymentAmount[2]);
                    Loan."Principal Arrears" := 0;
                    Loan."Interest Arrears" := 0;
                    Loan."Ledger Fee Arrears" := 0;
                    Loan."Penalty Arrears" := 0;
                    Loan."Total Arrears" := 0;
                    Loan."Days In Arrears" := 0;
                    Loan."Installment In Arrears" := 0;
                    Loan."Classification" := '';
                    Loan."Principal Overpayment" := OverpaymentAmount[1];
                    Loan."Interest Overpayment" := OverpaymentAmount[2];
                    //Loan.Modify();
                end;

                case ClassificationDesc of
                    'PERFORMING':
                        PERFORMING += Loan."Outstanding Balance";
                    'WATCH':
                        WATCH += Loan."Outstanding Balance";
                    'DOUBTFUL':
                        DOUBTFUL += Loan."Outstanding Balance";
                    'SUBSTANDARD':
                        SUBSTANDARD += Loan."Outstanding Balance";
                    'LOSS':
                        LOSS += Loan."Outstanding Balance";
                end;

                if (ClassificationDesc = 'WATCH') or (ClassificationDesc = 'DOUBTFUL') or (ClassificationDesc = 'SUBSTANDARD') or (ClassificationDesc = 'LOSS') then
                    TotalPAR += Loan."Outstanding Balance";

                TotalOLB += Loan."Outstanding Balance";

                if Loan."Date of Completion" <= Today then
                    ExpiredLoansArrears += LoanArrears
                else
                    ActiveLoansArrears += LoanArrears;
            //end;
            until Loan.Next = 0;
        end;
    end;

    var
        TotalArrears: Decimal;
        TotalPAR: Decimal;
        TotalOLB: Decimal;
        ExpiredLoansArrears: Decimal;
        ActiveLoansArrears: Decimal;

        InterestArrears: Decimal;
        PenaltyArrears: Decimal;

        PrincipalArrears: Decimal;

        TotalAmountDue: Decimal;

        PERFORMING: Decimal;
        WATCH: Decimal;
        DOUBTFUL: Decimal;
        SUBSTANDARD: Decimal;
        LOSS: Decimal;

}