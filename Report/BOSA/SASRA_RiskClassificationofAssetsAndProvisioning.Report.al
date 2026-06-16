report 50120 "Risk Class. of Assets Prov."
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report\BOSA\RiskClassificationofAssetsAndProvisioning.rdl';
    Caption = 'Risk Classification of Asets and Provisioning';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number);
            column(StartDate; StartDate)
            {

            }
            column(EndDate; EndDate)
            {

            }
            column(NoofLoanAccounts_1; NoofLoanAccounts[1])
            {

            }
            column(NoofLoanAccounts_2; NoofLoanAccounts[2])
            {

            }
            column(NoofLoanAccounts_3; NoofLoanAccounts[3])
            {

            }
            column(NoofLoanAccounts_4; NoofLoanAccounts[4])
            {

            }
            column(NoofLoanAccounts_5; NoofLoanAccounts[5])
            {

            }
            column(NoofLoanAccounts2_1; NoofLoanAccounts2[1])
            {

            }
            column(NoofLoanAccounts2_2; NoofLoanAccounts2[2])
            {

            }
            column(NoofLoanAccounts2_3; NoofLoanAccounts2[3])
            {

            }
            column(NoofLoanAccounts2_4; NoofLoanAccounts2[4])
            {

            }
            column(NoofLoanAccounts2_5; NoofLoanAccounts2[5])
            {

            }

            column(TotalOutstandingBalance_1; TotalOutstandingBalance[1])
            {

            }
            column(TotalOutstandingBalance_2; TotalOutstandingBalance[2])
            {

            }
            column(TotalOutstandingBalance_3; TotalOutstandingBalance[3])
            {

            }
            column(TotalOutstandingBalance_4; TotalOutstandingBalance[4])
            {

            }
            column(TotalOutstandingBalance_5; TotalOutstandingBalance[5])
            {

            }
            column(TotalOutstandingBalance2_1; TotalOutstandingBalance2[1])
            {

            }
            column(TotalOutstandingBalance2_2; TotalOutstandingBalance2[2])
            {

            }
            column(TotalOutstandingBalance2_3; TotalOutstandingBalance2[3])
            {

            }
            column(TotalOutstandingBalance2_4; TotalOutstandingBalance2[4])
            {

            }
            column(TotalOutstandingBalance2_5; TotalOutstandingBalance2[5])
            {

            }
            column(ProvisioningAmount_1; ProvisioningAmount[1])
            {

            }
            column(ProvisioningAmount_2; ProvisioningAmount[2])
            {

            }
            column(ProvisioningAmount_3; ProvisioningAmount[3])
            {

            }
            column(ProvisioningAmount_4; ProvisioningAmount[4])
            {

            }
            column(ProvisioningAmount_5; ProvisioningAmount[5])
            {

            }
            column(ProvisioningAmount2_1; ProvisioningAmount2[1])
            {

            }
            column(ProvisioningAmount2_2; ProvisioningAmount2[2])
            {

            }
            column(ProvisioningAmount2_3; ProvisioningAmount2[3])
            {

            }
            column(ProvisioningAmount2_4; ProvisioningAmount2[4])
            {

            }
            column(ProvisioningAmount2_5; ProvisioningAmount2[5])
            {

            }

            trigger OnPreDataItem()
            var

            begin
                SetRange(Number, 1, 1);
                if EndDate = 0D then
                    Error('As At Date cannot be blank');
                UpdateClassification();
            end;

            trigger OnAfterGetRecord()
            var
            begin
                // if StartDate = 0D then
                //Error('Start Date cannot be blank');
                CalculateLoanClassificationSummary();
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'As At Date';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    local procedure CalculateLoanClassificationSummary()
    var
    begin
        NoofLoanAccounts[1] := 0;
        NoofLoanAccounts[2] := 0;
        NoofLoanAccounts[3] := 0;
        NoofLoanAccounts[4] := 0;
        NoofLoanAccounts[5] := 0;
        NoofLoanAccounts2[1] := 0;
        NoofLoanAccounts2[2] := 0;
        NoofLoanAccounts2[3] := 0;
        NoofLoanAccounts2[4] := 0;
        NoofLoanAccounts2[5] := 0;

        TotalOutstandingBalance[1] := 0;
        TotalOutstandingBalance[2] := 0;
        TotalOutstandingBalance[3] := 0;
        TotalOutstandingBalance[4] := 0;
        TotalOutstandingBalance[5] := 0;
        TotalOutstandingBalance2[1] := 0;
        TotalOutstandingBalance2[2] := 0;
        TotalOutstandingBalance2[3] := 0;
        TotalOutstandingBalance2[4] := 0;
        TotalOutstandingBalance2[5] := 0;

        ProvisioningAmount[1] := 0;
        ProvisioningAmount[2] := 0;
        ProvisioningAmount[3] := 0;
        ProvisioningAmount[4] := 0;
        ProvisioningAmount[5] := 0;
        ProvisioningAmount2[1] := 0;
        ProvisioningAmount2[2] := 0;
        ProvisioningAmount2[3] := 0;
        ProvisioningAmount2[4] := 0;
        ProvisioningAmount2[5] := 0;


        LoanClassificationEntry.Reset();
        LoanClassificationEntry.SetRange("Classification Date", StartDate, EndDate);
        if LoanClassificationEntry.FindSet() then begin
            repeat
                if LoanClassificationEntry."Class Description" = 'PERFORMING' THEN begin
                    if IsRescheduledLoan(LoanClassificationEntry."Loan No.") then begin
                        NoofLoanAccounts2[1] += 1;
                        TotalOutstandingBalance2[1] += LoanClassificationEntry."Outstanding Balance";
                        ProvisioningAmount2[1] += LoanClassificationEntry."Provisioning Amount";
                    end else begin
                        NoofLoanAccounts[1] += 1;
                        TotalOutstandingBalance[1] += LoanClassificationEntry."Outstanding Balance";
                        ProvisioningAmount[1] += LoanClassificationEntry."Provisioning Amount";
                    end;
                end;

                if LoanClassificationEntry."Class Description" = 'WATCH' THEN begin
                    if IsRescheduledLoan(LoanClassificationEntry."Loan No.") then begin
                        NoofLoanAccounts2[2] += 1;
                        TotalOutstandingBalance2[2] += LoanClassificationEntry."Outstanding Balance";
                        ProvisioningAmount2[2] += LoanClassificationEntry."Provisioning Amount";
                    end else begin
                        NoofLoanAccounts[2] += 1;
                        TotalOutstandingBalance[2] += LoanClassificationEntry."Outstanding Balance";
                        ProvisioningAmount[2] += LoanClassificationEntry."Provisioning Amount";
                    end;
                end;
                if LoanClassificationEntry."Class Description" = 'SUBSTANDARD' THEN begin
                    if IsRescheduledLoan(LoanClassificationEntry."Loan No.") then begin
                        NoofLoanAccounts2[3] += 1;
                        TotalOutstandingBalance2[3] += LoanClassificationEntry."Outstanding Balance";
                        ProvisioningAmount2[3] += LoanClassificationEntry."Provisioning Amount";
                    end else begin
                        NoofLoanAccounts[3] += 1;
                        TotalOutstandingBalance[3] += LoanClassificationEntry."Outstanding Balance";
                        ProvisioningAmount[3] += LoanClassificationEntry."Provisioning Amount";
                    end;
                end;
                if LoanClassificationEntry."Class Description" = 'DOUBTFUL' THEN begin
                    if IsRescheduledLoan(LoanClassificationEntry."Loan No.") then begin
                        NoofLoanAccounts2[4] += 1;
                        TotalOutstandingBalance2[4] += LoanClassificationEntry."Outstanding Balance";
                        ProvisioningAmount2[4] += LoanClassificationEntry."Provisioning Amount";
                    end else begin
                        NoofLoanAccounts[4] += 1;
                        TotalOutstandingBalance[4] += LoanClassificationEntry."Outstanding Balance";
                        ProvisioningAmount[4] += LoanClassificationEntry."Provisioning Amount";
                    end;
                end;
                if LoanClassificationEntry."Class Description" = 'LOSS' THEN begin
                    if IsRescheduledLoan(LoanClassificationEntry."Loan No.") then begin
                        NoofLoanAccounts2[5] += 1;
                        TotalOutstandingBalance2[5] += LoanClassificationEntry."Outstanding Balance";
                        ProvisioningAmount2[5] += LoanClassificationEntry."Provisioning Amount";
                    end else begin
                        NoofLoanAccounts[5] += 1;
                        TotalOutstandingBalance[5] += LoanClassificationEntry."Outstanding Balance";
                        ProvisioningAmount[5] += LoanClassificationEntry."Provisioning Amount";
                    end;

                end;
            until LoanClassificationEntry.Next() = 0;
        end;
    end;

    local procedure UpdateClassification()
    var
        BOSAManagement: Codeunit "BOSA Management";
        ProgressWindow: Dialog;
        i: Integer;
        TotalLoan: Integer;
        Text000: Label 'Generating Loan Classification\';
        Text001: Label 'Member No.      #1#############################\';
        Text002: Label 'Member Name      #2#############################\';
        Text003: Label 'Loan No.          #3#############################\\';
        Text004: Label 'Description       #4#############################\';
        Text005: Label 'Progress          @5@@@@@@@@@@@@@@@@@@@@@@@\';
        LoanApp: Record "Loan Application";
    begin
        LoanClassificationEntry.Reset();
        if LoanClassificationEntry.FindSet() then
            LoanClassificationEntry.DELETEALL;

        LoanApp.Reset();
        LoanApp.SetRange(Posted, true);
        LoanApp.SetFilter("Date Filter", '<=%1', EndDate);
        if LoanApp.FindSet() then begin
            TotalLoan := LoanApp.COUNT;
            //Message('Loan Count %1', TotalLoan);
            IF GUIALLOWED THEN
                ProgressWindow.OPEN(Text000 + Text001 + Text002 + Text003 + Text004 + Text005);
            repeat
                IF GUIALLOWED THEN BEGIN
                    i += 1;
                    ProgressWindow.UPDATE(1, LoanApp."Member No.");
                    ProgressWindow.UPDATE(2, LoanApp."Member Name");
                    ProgressWindow.UPDATE(3, LoanApp."No.");
                    ProgressWindow.UPDATE(4, LoanApp.Description);
                    LoanApp.CalcFields("Outstanding Balance");
                    if LoanApp."Outstanding Balance" > 0 then begin
                        BOSAManagement.GenerateLoanClassification(LoanApp, EndDate);
                    end;
                    ProgressWindow.UPDATE(5, (i / TotalLoan * 10000) DIV 1);
                END;
                SLEEP(50);
            until LoanApp.Next = 0;
            ProgressWindow.CLOSE;
        end;

    end;

    local procedure IsRescheduledLoan(LoanNo: Code[10]): Boolean
    var
        LoanRescheduling: Record "Loan Rescheduling";
    begin
        LoanRescheduling.Reset();
        LoanRescheduling.SetRange("Loan No.", LoanNo);
        LoanRescheduling.SetRange(Status, LoanRescheduling.Status::Approved);
        exit(LoanRescheduling.FindFirst());

    end;

    var
        StartDate: Date;
        EndDate: Date;
        LoanClassificationEntry: Record "Loan Classification Entry";
        LoanClassificationSetup: Record "Loan Classification Setup";
        NoofLoanAccounts: array[10] of Integer;
        TotalOutstandingBalance: array[10] of Decimal;
        NoofLoanAccounts2: array[10] of Integer;
        TotalOutstandingBalance2: array[10] of Decimal;
        ProvisioningAmount: array[10] of Decimal;
        ProvisioningAmount2: array[10] of Decimal;


}