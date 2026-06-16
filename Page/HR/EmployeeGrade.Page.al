page 50458 "Employee Grades"
{
    // version TL2.0

    PageType = List;
    SourceTable = 50231;

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
                field("Salary Scale Minimum"; Rec."Salary Scale Minimum")
                {
                    ApplicationArea = All;
                }
                field("Salary Scale Maximum"; Rec."Salary Scale Maximum")
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
