page 50211 "Loan Refinancing Entries"
{
    // version TL2.0

    Caption = 'Loans To Refinance';
    PageType = List;
    SourceTable = "Loan Refinancing Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan To Refinance"; Rec."Loan To Refinance")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

