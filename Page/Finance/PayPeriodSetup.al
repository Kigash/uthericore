page 50501 "Pay Period Setup"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Payroll Period";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Date Locked"; Rec."Date Locked")
                {
                    ApplicationArea = All;
                }
                field("Pay Date"; Rec."Pay Date")
                {
                    ApplicationArea = All;
                }
                field("NetPay Transfered"; Rec."NetPay Transfered")
                {
                    ApplicationArea = All;
                }
                field("Close Pay"; Rec."Close Pay")
                {
                    ApplicationArea = All;
                }
                field("P.A.Y.E"; Rec."P.A.Y.E")
                {
                    ApplicationArea = All;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                }
                field("Closed on Date"; Rec."Closed on Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Sendslip; Rec.Sendslip)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Start Approval"; Rec."Start Approval")
                {
                    ApplicationArea = All;
                }
                field("Period code"; Rec."Period code")
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("&Create Period")
            {
                Caption = '&Create Period';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = CreateReminders;
                RunObject = Report 50401;
            }
            action("&Close Pay Period")
            {
                Caption = '&Close Pay Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    PayrollProcessing.ClosingPayrollPeriod();
                end;
            }
        }
    }

    var
        PayrollProcessing: Codeunit "Payroll Processing";
}

