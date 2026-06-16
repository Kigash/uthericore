page 50216 "Loan Charge Setup"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Loan Charge Setup";
    UsageCategory = Lists;
    ApplicationArea = All;

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Income G/L Account"; Rec."Income G/L Account")
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

