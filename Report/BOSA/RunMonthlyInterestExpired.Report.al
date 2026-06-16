report 57901 "Run Monthly Interest Expired"
{
    // version TL2.0

    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem("Loan Application"; "Loan Application")
        {
            DataItemTableView = where(Posted = Filter(true), "Pause Loan Interest" = Filter(false), "Loan Restructured" = filter(false));

            trigger OnPreDataItem()
            begin
                LoanApplicationSetup.Get();
                LoanApplicationSetup.TestField("Loan Interest Template Name");
                LoanApplicationSetup.TestField("Loan Interest Batch Name");

                GlobalManagement.ClearJournal(LoanApplicationSetup."Loan Interest Template Name", LoanApplicationSetup."Loan Interest Batch Name");

                IF GUIALLOWED THEN
                    i := 0;
                TotalLoanAccount := COUNT;
                IF GUIALLOWED THEN
                    ProgressWindow.OPEN(Text000 + Text001 + Text002 + Text003 + Text004 + Text005);
            end;

            trigger OnAfterGetRecord()
            var
                Customer: Record Customer;
                Cust: Record Customer;
                Memb: Record Member;
                CustL: Record "Cust. Ledger Entry";
            begin
                if PostingDate = 0D then
                    PostingDate := Today;

                RunDate := PostingDate;

                "Loan Application".CalcFields("Outstanding Balance");
                if ("Loan Application"."Outstanding Balance" > 0) and ("Loan Application"."Date of Completion" <> 0D) then begin
                    if "Loan Application"."Date of Completion" > RunDate then begin
                        CurrReport.Skip();
                    end else begin
                        if Date2DMY("Loan Application"."Disbursal Date", 1) = Date2DMY(RunDate, 1) then begin
                            Cust.Reset();
                            Cust.SetRange("No.", "Loan Application"."No.");
                            If Cust.FindFirst() then begin
                                CustL.Reset();
                                CustL.SetRange("Transaction Type Code", 'INTDUE');
                                CustL.SetRange("Posting Date", RunDate);
                                CustL.SetRange(Reversed, false);
                                If CustL.FindFirst() then begin
                                    CurrReport.Skip();
                                end else begin
                                    i += 1;
                                    IF GUIALLOWED THEN begin
                                        ProgressWindow.UPDATE(1, "Member No.");
                                        ProgressWindow.UPDATE(2, "Member Name");
                                        ProgressWindow.UPDATE(3, "No.");
                                        ProgressWindow.UPDATE(4, Description);
                                    end;

                                    If Memb.Get("Loan Application"."Member No.") then begin
                                        If "Loan Application"."Global Dimension 1 Code" = '' then begin
                                            "Loan Application"."Global Dimension 1 Code" := Memb."Global Dimension 1 Code";
                                            "Loan Application".Modify();
                                            Cust."Global Dimension 1 Code" := Memb."Global Dimension 1 Code";
                                            Cust.Modify();
                                        end;
                                    end;

                                    BOSAManagement.CapitalizeInterest(Cust, RunDate, PostingDate);
                                    IF GUIALLOWED THEN
                                        ProgressWindow.UPDATE(5, (i / TotalLoanAccount * 10000) DIV 1);
                                    SLEEP(0);
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                IF GUIALLOWED THEN BEGIN
                    IF GlobalManagement.PostJournal(LoanApplicationSetup."Loan Interest Template Name", LoanApplicationSetup."Loan Interest Batch Name") THEN BEGIN

                    END ELSE
                        ERROR(GETLASTERRORTEXT);
                end;
            end;
        }

    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        //IF GUIALLOWED THEN BEGIN
        //IF GlobalManagement.PostJournal(LoanApplicationSetup."Loan Interest Template Name", LoanApplicationSetup."Loan Interest Batch Name") THEN BEGIN
        //UpdateNexDueDate(LoanApplication);
        //END ELSE
        //ERROR(GETLASTERRORTEXT);
        //end;
    end;

    var
        Text000: Label 'Processing Interest..\';
        Text001: Label 'Member No.   #1#############################\';
        Text002: Label 'Member Name  #2#############################\';
        Text003: Label 'Loan No.     #3#############################\\';
        Text004: Label 'Description  #4#############################\';
        Text005: Label 'Progress          @5@@@@@@@@@@@@@@@@@@@@@@@\';
        Text007: Label 'Posting failed';
        Text008: Label 'Kindly indicate interest run date';
        ProgressWindow: Dialog;
        i: Integer;
        TotalLoanAccount: Integer;
        BOSAManagement: Codeunit "BOSA Management";
        GlobalManagement: Codeunit "Global Management";
        LoanApplicationSetup: Record "Loan Application Setup";
        LoanApplication: Record "Loan Application";
        DateFormula: DateFormula;
        RunDate: Date;
        PostingDate: Date;
        LoanRep: Record "Loan Repayment Schedule";


}

