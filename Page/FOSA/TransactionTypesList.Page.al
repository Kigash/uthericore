page 50026 "Transaction Types List"
{
    // version TL2.0

    CardPageID = "Transaction Types Card";
    Caption = 'Transaction Types Teller';
    PageType = List;
    SourceTable = "Transaction -Type";
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;
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
                field("Service ID"; Rec."Service ID")
                {
                    ApplicationArea = All;
                }
                field("Application Area"; Rec."Application Area")
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

