page 50118 "Employer Company List"
{
    ApplicationArea = All;
    Caption = 'Employer Company List';
    PageType = List;
    SourceTable = "Check Off Company";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Company Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
            }
        }
    }
}
