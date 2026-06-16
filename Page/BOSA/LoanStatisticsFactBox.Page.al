page 50196 "Loan Statistics FactBox"
{
    // version TL2.0

    Caption = 'Loan Statistics';
    PageType = CardPart;
    SourceTable = "Loan Application";

    layout
    {
        area(content)
        {
            field("Approved Amount"; Rec."Approved Amount")
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
            field("Total Arrears"; Rec."Total Arrears")
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
            field("Total Loan Outstanding Balance"; Rec."Outstanding Balance")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

