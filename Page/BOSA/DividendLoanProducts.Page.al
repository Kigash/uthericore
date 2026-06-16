page 50323 "Dividend Loan Products"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Dividend Loan Product";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
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

