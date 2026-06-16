page 50208 "Security Type List"
{
    // version TL2.0

    Caption = 'Security Types';
    PageType = List;
    SourceTable = "Security Type";
    UsageCategory = Administration;
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
                field(Factor; Rec.Factor)
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

