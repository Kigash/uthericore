page 50119 Denomination
{
    // version TL2.0

    PageType = List;
    SourceTable = Denomination;

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
                field(Value; Rec.Value)
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

