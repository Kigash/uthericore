page 50506 "HR Earnings & Deductions"
{
    PageType = List;
    SourceTable = "Payroll Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Loan Principal"; Rec."Loan Principal")
                {
                    ApplicationArea = All;
                }
                field("Loan Interest"; Rec."Loan Interest")
                {
                    ApplicationArea = All;
                }
                field("Loan Ledger Fee"; Rec."Loan Ledger Fee")
                {
                    ApplicationArea = All;
                }
                field("Loan Penalty"; Rec."Loan Penalty")
                {
                    ApplicationArea = All;
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                    ApplicationArea = All;
                }
                field("Employee Voluntary"; Rec."Employee Voluntary")
                {
                    ApplicationArea = All;
                }
                field("Taxable amount"; Rec."Taxable amount")
                {
                    Editable = false;
                }
                field("Next Period Entry"; Rec."Next Period Entry")
                {
                    ApplicationArea = All;
                }
                field("Tax Relief"; Rec."Tax Relief")
                {
                    ApplicationArea = All;
                }
                field("Normal Earnings"; Rec."Normal Earnings")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
    //  PayrollProcessing : Codeunit "50038";
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            if UserSetup."View Payroll" = false then begin
                Error('You do not have permission to view this page');
            end;
        end;
    end;
}

