report 57001 "Run Monthly Interest"
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
                if PostingDate = 0D then
                    PostingDate := Today;

                RunDate := PostingDate;

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
                DCustL: Record "Cust. Ledger Entry";
            begin

                Cust.Reset();
                Cust.SetRange("No.", "Loan Application"."No.");
                Cust.SetRange(Status, Cust.Status::Blocked);
                If Cust.FindFirst() then begin
                    CurrReport.Skip();
                end else begin
                    "Loan Application".CalcFields("Outstanding Balance");
                    if "Loan Application"."Outstanding Balance" > 0 then begin
                        i += 1;
                        IF GUIALLOWED THEN begin
                            ProgressWindow.UPDATE(1, "Member No.");
                            ProgressWindow.UPDATE(2, "Member Name");
                            ProgressWindow.UPDATE(3, "No.");
                            ProgressWindow.UPDATE(4, Description);
                        end;
                        DCustL.Reset();
                        DCustL.SetRange("Customer No.", "Loan Application"."No.");
                        DCustL.SetRange("Transaction Type Code", 'INTDUE');
                        DCustL.SetRange("Posting Date", PostingDate);
                        DCustL.SetRange(Reversed, false);
                        If DCustL.FindFirst() then begin
                            CurrReport.Skip();
                        end else begin
                            if "Loan Application"."Date of Completion" > RunDate then begin
                                LoanRep.Reset();
                                LoanRep.SetRange("Loan No.", "Loan Application"."No.");
                                LoanRep.SetRange("Repayment Date", RunDate);
                                If LoanRep.FindFirst() then begin
                                    Customer.Get("Loan Application"."No.");
                                    BOSAManagement.CapitalizeInterest(Customer, RunDate, PostingDate);
                                end;
                            end else begin
                                if Date2DMY("Loan Application"."Disbursal Date", 1) = Date2DMY(RunDate, 1) then begin
                                    Customer.Get("Loan Application"."No.");
                                    BOSAManagement.CapitalizeInterestExpired(Customer, RunDate, PostingDate);
                                end;
                            end;
                        end;
                        IF GUIALLOWED THEN
                            ProgressWindow.UPDATE(5, (i / TotalLoanAccount * 10000) DIV 1);
                        SLEEP(0);
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

