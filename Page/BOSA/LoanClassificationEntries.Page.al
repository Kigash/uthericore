page 50300 "Loan Classification Entries"
{
    // version TL2.0

    Editable = false;
    PageType = List;
    SourceTable = "Loan Classification Entry";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Classification Date"; Rec."Classification Date")
                {
                    ApplicationArea = All;
                }
                field("Classification Time"; Rec."Classification Time")
                {
                    ApplicationArea = All;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Deposit Balance"; Rec."Deposit Balance" * -1)
                { }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = All;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = All;
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    ApplicationArea = All;
                }
                field("Loan Start Date"; Rec."Loan Start Date")
                { }

                field("Expected Completion Date"; Rec."Expected Completion Date")
                {

                }
                field("Remaining Period"; Rec."Remaining Period")
                {
                    ApplicationArea = All;
                }
                field("Remaining Principal Amount"; Rec."Remaining Principal Amount")
                {
                    ApplicationArea = All;
                }
                field("Remaining Interest Amount"; Rec."Remaining Interest Amount")
                {
                    ApplicationArea = All;
                }
                field("Principal Installment"; Rec."Principal Installment")
                {
                    ApplicationArea = All;
                }
                field("Interest Installment"; Rec."Interest Installment")
                {
                    ApplicationArea = All;
                }
                field("Total Installment"; Rec."Total Installment")
                {
                    ApplicationArea = All;
                }
                field("Principal Overpayment"; Rec."Principal Overpayment")
                {
                    ApplicationArea = All;
                }
                field("Interest Overpayment"; Rec."Interest Overpayment")
                {
                    ApplicationArea = All;
                }
                field("Total Overpayment"; Rec."Total Overpayment")
                {
                    ApplicationArea = All;
                }
                field("Principal Arrears"; Rec."Principal Arrears")
                {
                    ApplicationArea = All;
                }
                field("Interest Arrears"; Rec."Interest Arrears")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Arrears"; Rec."Ledger Fee Arrears")
                {
                    ApplicationArea = All;
                }
                field("Penalty Arrears"; Rec."Penalty Arrears")
                {
                    ApplicationArea = All;
                }
                field("Total Arrears"; Rec."Total Arrears")
                {
                    ApplicationArea = All;
                }

                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                }
                field("Provisioning Amount"; Rec."Provisioning Amount")
                {
                    ApplicationArea = All;
                }
                field("Classification Code"; Rec."Classification Code")
                {
                    ApplicationArea = All;
                }
                field("Class Description"; Rec."Class Description")
                {
                    ApplicationArea = All;
                }
                field("No. of Days in Arrears"; Rec."No. of Days in Arrears")
                {
                    ApplicationArea = All;
                }
                field("No. of Defaulted Installment"; Rec."No. of Defaulted Installment")
                {
                    ApplicationArea = All;
                }
                field("Last Payment Date"; Rec."Last Payment Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(Print)
            {
                Image = BankAccountStatement;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //REPORT.RUN(REPORT::"Loan Classification Report",TRUE,FALSE);
                end;
            }
        }
    }
}

