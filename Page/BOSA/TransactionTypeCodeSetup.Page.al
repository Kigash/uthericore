page 50028 "Transaction Type Code Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Transaction Type Code Setup";

    layout
    {
        area(Content)
        {
            group(FOSA)
            {
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = All;
                }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    ApplicationArea = All;
                }
                field("Withheld Sep10th 2024 Code"; Rec."Withheld Sep10th 2024 Code")
                {
                    ApplicationArea = All;
                }
                field("Deposits From Sep10th 2024 Code"; Rec."Deposits From Sep10th 2024 Code")
                {
                    ApplicationArea = All;
                }
            }
            group(BOSA)
            {
                field("Opening Balance"; Rec."Opening Balance")
                {
                    ApplicationArea = All;

                }
                field("New Loan"; Rec."New Loan")
                {
                    ApplicationArea = All;

                }
                field("Principal Paid"; Rec."Principal Paid")
                {
                    ApplicationArea = All;

                }
                field("Interest Paid"; Rec."Interest Paid")
                {
                    ApplicationArea = All;

                }
                field("Interest Due"; Rec."Interest Due")
                {
                    ApplicationArea = All;

                }
                field("Ledger Fee Due"; Rec."Ledger Fee Due")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Paid"; Rec."Ledger Fee Paid")
                {
                    ApplicationArea = All;

                }
                field("Penalty Due"; Rec."Penalty Due")
                {
                    ApplicationArea = All;

                }
                field("Penalty Paid"; Rec."Penalty Paid")
                {
                    ApplicationArea = All;

                }
                field("Processing Fee"; Rec."Processing Fee")
                {
                }
                field("Insurance Fee"; Rec."Insurance Fee")
                {
                    ApplicationArea = All;
                }
                field("Refinancing Fee"; Rec."Refinancing Fee")
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
            /*  action(ActionName)
             {
                 ApplicationArea = All;

                 trigger OnAction()
                 begin

                 end;
             } */
        }
    }

    var
        myInt: Integer;
}